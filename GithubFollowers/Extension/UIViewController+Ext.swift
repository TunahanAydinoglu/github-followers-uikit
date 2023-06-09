//
//  UIViewController+Ext.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 27.10.2022.
//

import UIKit
import SafariServices

extension UIViewController{

  func presentGFAlert(title: String, message: String, buttonTitle: String) {
      let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      present(alertVC, animated: true)
  }

  func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
    DispatchQueue.main.async {
      let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      self.present(alertVC, animated: true)
    }
  }

  func presentDefaultError() {
    let alertVC = GFAlertVC(
      title: Constants.Errors.smtError,
      message: Constants.Errors.uncompleteTask,
      buttonTitle: Constants.Texts.ok
    )
      alertVC.modalPresentationStyle = .overFullScreen
      alertVC.modalTransitionStyle = .crossDissolve
      present(alertVC, animated: true)
  }

  func presentSafariVC(with url: URL) {
    let safariVC = SFSafariViewController(url: url)
    safariVC.preferredControlTintColor = .systemGreen
    present(safariVC, animated: true)
  }
}
