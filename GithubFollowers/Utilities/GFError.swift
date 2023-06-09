//
//  GFError.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 25.11.2022.
//

import Foundation

enum GFError: String, Error {
  case invalidUsername = "This username created an invalid request. Please try again."
  case unableToComplete = "Unable to complete your reques. Please check your internet connection."
  case invalidResponse = "Invalid response from the server. Please try again."
  case invalidData = "The data received from the server was invalid. Please try again."
  case unableToFavorite = "There was an error favoriting this user. Please try again."
  case alreadyInFavorites = "You have already favorited this user."
}
