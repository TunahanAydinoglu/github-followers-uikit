//
//  Follower.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 2.11.2022.
//

import Foundation

struct Follower: Codable, Hashable {
  var login: String
  var avatarUrl: String
}
