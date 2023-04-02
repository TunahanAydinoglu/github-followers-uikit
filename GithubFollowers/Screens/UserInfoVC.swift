//
//  UserInfoVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 25.03.2023.
//

import UIKit

class UserInfoVC: UIViewController {

  private enum Layout {
    static let padding: CGFloat = 20
    static let headerHeight: CGFloat = 180
    static let itemHeigh: CGFloat = 140
  }

  private let headerView = UIView()
  private let itemViewOne = UIView()
  private let itemViewTwo = UIView()

  var userName: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewContoller()
    layoutUI()

    getUserInfo()
  }

  private func configureViewContoller() {
    view.backgroundColor = .systemBackground
    let doneButton = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(dismissVC)
    )
    navigationItem.rightBarButtonItem = doneButton
  }

  private func layoutUI() {
    let subViews = [headerView, itemViewOne, itemViewTwo]
    for itemView in subViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false

      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.padding),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.padding)
      ])
    }

    itemViewOne.backgroundColor = .yellow
    itemViewTwo.backgroundColor = .blue

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: Layout.headerHeight),

      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Layout.padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: Layout.itemHeigh),

      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: Layout.padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: Layout.itemHeigh)
    ])
  }

  private func add(childVC: UIViewController, to containerView: UIView) {
    addChild(childVC)
    containerView.addSubview(childVC.view)
    childVC.view.frame = containerView.bounds
    childVC.didMove(toParent: self)
  }
  
  @objc func dismissVC() {
    dismiss(animated: true)
  }
}

// MARK: Network
extension UserInfoVC {
  private func getUserInfo() {
    NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
      guard let self = self else { return }

      switch result {
      case .success(let user):
        DispatchQueue.main.async {
          self.add(childVC: GFUserInfoVC(user: user), to: self.headerView)
        }
      case .failure(let error):
        self.presentGFAlertOnMainThread(
          title: Constants.Errors.smtError,
          message: error.rawValue,
          buttonTitle: Constants.Texts.ok
        )
      }
    }
  }
}
