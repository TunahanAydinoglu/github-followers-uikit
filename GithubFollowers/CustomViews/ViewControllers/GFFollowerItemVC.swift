//
//  GFFollowerItemVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 5.04.2023.
//

import UIKit

protocol GFFollowerItemVCDelegate: AnyObject {
  func didTapGetFollowers(for user: User)
}

final class GFFollowerItemVC: GFItemInfoVC {

  weak var delegate: GFFollowerItemVCDelegate?

  init(user: User, delegate: GFFollowerItemVCDelegate) {
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
    delegate?.didTapGetFollowers(for: user)
  }
  
  private func configureItems() {
    itemInfoViewLeading.set(for: .followers, with: user.followers)
    itemInfoViewTrailing.set(for: .following, with: user.following)
    actionButton.set(backgroundColor: .systemGreen, title: Constants.Texts.getFollowers)
  }
}
