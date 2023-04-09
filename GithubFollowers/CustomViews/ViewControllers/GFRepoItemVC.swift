//
//  GFRepoItemVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 5.04.2023.
//

import UIKit

protocol GFRepoItemVCDelegate: AnyObject {
  func didTapGithubProfile(for user: User)
}

final class GFRepoItemVC: GFItemInfoVC {

  weak var delegate: GFRepoItemVCDelegate?

  init(user: User, delegate: GFRepoItemVCDelegate) {
    super.init(user: user)
    self.delegate = delegate
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    configureItems()
  }

  override func actionButtonTapped() {
    delegate?.didTapGithubProfile(for: user)
  }

  private func configureItems() {
    itemInfoViewLeading.set(for: .repos, with: user.publicRepos)
    itemInfoViewTrailing.set(for: .gists, with: user.publicGists)
    actionButton.set(backgroundColor: .systemPurple, title: Constants.Texts.githubProfile)
  }
}
