//
//  GFDataLoadingVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 8.04.2023.
//

import UIKit

class GFDataLoadingVC: UIViewController {

  var containerView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()

  }

  func showLoadingView() {
    containerView = UIView(frame: view.bounds)
    guard let containerView = containerView else { return }
    view.addSubview(containerView)
    containerView.backgroundColor = .systemBackground
    containerView.alpha = 0

    UIView.animate(withDuration: 0.25) {
      containerView.alpha = 0.8
    }

    let activityIndicator = UIActivityIndicatorView(style: .large)
    containerView.addSubview(activityIndicator)

    activityIndicator.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])

    activityIndicator.startAnimating()
  }

  func dismissLoadingView() {
    DispatchQueue.main.async {
      self.containerView?.removeFromSuperview()
      self.containerView = nil
    }
  }

  func showEmptyStateView(with message: String, in view: UIView) {
    let emptyStateView = GFEmptyStateView(message: message)
    emptyStateView.frame = view.bounds
    view.addSubview(emptyStateView)
  }

}
