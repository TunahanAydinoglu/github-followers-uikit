//
//  NetworkManager.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 2.11.2022.
//

import UIKit

class NetworkManager {
  static let shared = NetworkManager()
  static let perPageCount = 40
  private let baseURL = "https://api.github.com/users/"
  let cache = NSCache<NSString, UIImage>()
  let decoder = JSONDecoder()
  
  private init() {
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    decoder.dateDecodingStrategy = .iso8601
  }

  func getFollowers(for username: String, page: Int) async throws -> [Follower] {
    
    let endPoint = baseURL + "\(username)/followers?per_page=\(NetworkManager.perPageCount)&page=\(page)"
    
    guard let url = URL(string: endPoint) else {
      throw GFError.invalidUsername
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard
      let response = response as? HTTPURLResponse,
      response.statusCode == 200 else {
      throw GFError.invalidResponse
    }
    
    do {
      return try decoder.decode([Follower].self, from: data)
    } catch {
      throw GFError.invalidData
    }
  }

  func getUserInfo(for username: String, completed: @escaping(Result<User, GFError>) -> Void)  {
    
    let endPoint = baseURL + "\(username)"
    
    guard let url = URL(string: endPoint) else {
      completed(.failure(.invalidUsername))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      
      if let _ = error {
        completed(.failure(.unableToComplete))
        return
      }
      
      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.invalidResponse))
        return
      }
      
      guard let data = data else {
        completed(.failure(.invalidData))
        return
      }
      
      do {
        let user = try self.decoder.decode(User.self, from: data)
        completed(.success(user))
      } catch {
        completed(.failure(.invalidData))
      }
    }
    
    task.resume()
  }

  func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void){
    let cacheKey = NSString(string: urlString)
    if let image = cache.object(forKey: cacheKey) {
      completed(image)
      return
    }

    guard let url = URL(string: urlString) else {
      completed(nil)
      return
    }

    let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, err in
      guard let self = self,
            err == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode == 200,
            let data = data,
            let image = UIImage(data: data)
      else {
        completed(nil)
        return
      }

      self.cache.setObject(image, forKey: cacheKey)

      completed(image)
    }
    task.resume()
  }
}
