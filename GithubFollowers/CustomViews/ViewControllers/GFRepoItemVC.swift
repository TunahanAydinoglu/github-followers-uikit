//
//  GFRepoItemVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 5.04.2023.
//

import UIKit

final class GFRepoItemVC: GFItemInfoVC {

  override func viewDidLoad() {
    super.viewDidLoad()

    configureItems()
  }

  private func configureItems() {
    itemInfoViewLeading.set(for: .repos, with: user.publicRepos)
    itemInfoViewTrailing.set(for: .gists, with: user.publicGists)
    actionButton.set(backgroundColor: .systemPurple, title: Constants.Texts.githubProfile)
  }
}
