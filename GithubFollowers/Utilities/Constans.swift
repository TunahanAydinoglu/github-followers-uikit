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
  }

  enum Texts {
    // MARK: - Components
    static let ok: String = "Ok"
    static let usernamePlaceholder: String = "Enter a username"

    // MARK: - Errors
    static let emptyFollowers: String = "This user doesn't have any followers. Go follow them 😃"
    static let badStuff: String = "Bad Stuff Happend"
    static let smtError: String = "Someting went wrong!"
    static let uncompleteError: String = "Unable to complete request"
  }
}
