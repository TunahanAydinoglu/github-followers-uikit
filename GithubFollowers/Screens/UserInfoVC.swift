//
//  UserInfoVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 25.03.2023.
//

import UIKit

class UserInfoVC: UIViewController {

  var userInfo: Follower?

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(dismissVC)
    )
    navigationItem.rightBarButtonItem = doneButton
    print(userInfo?.login ?? "empty")
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }

}
