//
//  Constans.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 25.03.2023.
//

import Foundation

enum Constants{
  
  enum Images {
    static let emptyStateLogoName: String = "empty-state-logo"
    static let avatarPlaceHolder: String = "avatar-placeholder"

    // MARK: - SF Symbols
    static let locationPin: String = "mappin.and.ellipse"
  }
  
  enum Texts {
    // MARK: - Components
    static let ok: String = "Ok"
    static let usernamePlaceholder: String = "Enter a username"
    static let searchPlaceholder: String = "Search for a username"

    // MARK: - Empty value placeholders
    static let emptyString: String = ""
    static let noLocation: String = "No Location"
    static let noBioAvailable: String = "No bio available"
  }
  
  enum Errors {
    static let emptyFollowers: String = "This user doesn't have any followers. Go follow them 😃"
    static let badStuff: String = "Bad Stuff Happend"
    static let smtError: String = "Someting went wrong!"
    static let uncompleteError: String = "Unable to complete request"
  }
}
