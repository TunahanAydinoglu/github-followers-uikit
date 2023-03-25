//
//  User.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 2.11.2022.
//

import Foundation

struct User: Codable {
  var login: String
  var avatarUrl: String
  var name: String?
  var location: String?
  var bio: String?
  var publicResos: Int
  var publicGist: Int
  var htmlUrl: String
  var following: Int
  var followers: Int
  var createdAt: String
}
