//
//  GFFollowerItemVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 5.04.2023.
//

import UIKit

final class GFFollowerItemVC: GFItemInfoVC {

  override func viewDidLoad() {
    super.viewDidLoad()

    configureItems()
  }

  private func configureItems() {
    itemInfoViewLeading.set(for: .followers, with: user.followers)
    itemInfoViewTrailing.set(for: .following, with: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: Constants.Texts.getFollowers)
  }
}
