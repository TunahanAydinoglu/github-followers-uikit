//
//  Constans.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 25.03.2023.
//

import UIKit

enum Constants{
  enum Texts {
    // MARK: - Components
    static let search: String = "Search"
    static let favorites: String = "Favorites"
    static let ok: String = "Ok"
    static let emptyUsername: String = "Empty Username"
    static let usernamePlaceholder: String = "Enter a username"
    static let searchPlaceholder: String = "Search for a username"
    static let publicRepos: String = "Public Repos"
    static let publicGists: String = "Public Gists"
    static let followers: String = "Followers"
    static let following: String = "Following"
    static let githubProfile: String = "Github Profile"
    static let getFollowers: String = "Get Followers"
    static let githubSinceWithDate: String = "Github since {date}"
    static let success: String = "Success!"
    static let succeededFavorie: String = "You've successfully favorited this user 🤘🏼"
    static let pleaseUserName: String = "Please enter a username. We need to know who to look for 😉"

    static let noFollowers: String = "No Followers"
    static let invalidUrl: String = "Invalid URL"
    
    // MARK: - Empty value placeholders
    static let emptyString: String = ""
    static let noLocation: String = "No Location"
    static let noBioAvailable: String = "No bio available"
    static let noFavorites: String = "No Favorites!\n Add one on the followers screen."
  }
  
  enum Errors {
    static let emptyFollowers: String = "This user doesn't have any followers.\nGo follow them 😃"
    static let badStuff: String = "Bad Stuff Happend"
    static let smtError: String = "Someting went wrong!"
    static let uncompleteError: String = "Unable to complete request"
    static let unableRemove: String = "Unable to remove"
    static let uncompleteTask: String = "We were unable to complete your task at this time.\nPlease try again."

    static let userUrlNotValid: String = "The url attached to this user is invalid"
  }
}
enum Images {
  static let emptyStateLogo = UIImage(named: "empty-state-logo")
  static let avatarPlaceholder = UIImage(named: "avatar-placeholder")
  static let githubLogo = UIImage(named:"gh-logo")

  // MARK: - SF Symbols
  static let locationPin = UIImage(systemName: "mappin.and.ellipse")
  static let folder = UIImage(systemName: "folder")
  static let textAlignStart = UIImage(systemName: "text.alignleft")
  static let hearthEmpty = UIImage(systemName: "hearth")
  static let personsEmpty = UIImage(systemName: "person.2")
}

enum ScreenSize {
  static let width = UIScreen.main.bounds.size.width
  static let height = UIScreen.main.bounds.size.height
  static let maxLength = max(ScreenSize.width, ScreenSize.height)
  static let minLength = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
  static let idiom = UIDevice.current.userInterfaceIdiom
  static let nativeScale = UIScreen.main.nativeScale
  static let scale = UIScreen.main.scale

  static let isiphoneSE = idiom == .phone && ScreenSize.maxLength == 568.0
  static let isiphone8Standart = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
  static let isiphone8Zoomed = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
  static let isiphone8PlusStandart = idiom == .phone && ScreenSize.maxLength == 736.0
  static let isiphone8PlusZoomed = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
  static let isiphoneX = idiom == .phone && ScreenSize.maxLength == 812.0
  static let isiphoneXsMaxAndXr = idiom == .phone && ScreenSize.maxLength == 896.0
  static let isiPad = idiom == .pad && ScreenSize.maxLength >= 1024.0
  
  static func isiPhoneXAspectRatio() -> Bool {
    return isiphoneX || isiphoneXsMaxAndXr
  }
  static var isSmallScreen: Bool = {
    isiphoneSE || isiphone8Zoomed
  }()
}
