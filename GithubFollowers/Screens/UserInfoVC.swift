//
//  UserInfoVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 25.03.2023.
//

import UIKit

class UserInfoVC: UIViewController {

  var userName: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(dismissVC)
    )
    navigationItem.rightBarButtonItem = doneButton
    NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let user):
        print(user)
      case .failure(let error):
        self.presentGFAlertOnMainThread(
          title: Constants.Errors.smtError,
          message: error.rawValue,
          buttonTitle: Constants.Texts.ok
        )
      }
    }
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }

}
