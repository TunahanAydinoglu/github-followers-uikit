//
//  User.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 2.11.2022.
//

import Foundation

struct User: Codable {
  let login: String
  let avatarUrl: String
  var name: String?
  var location: String?
  var bio: String?
  let publicRepos: Int
  let publicGists: Int
  let htmlUrl: String
  let following: Int
  let followers: Int
  let createdAt: String
}
