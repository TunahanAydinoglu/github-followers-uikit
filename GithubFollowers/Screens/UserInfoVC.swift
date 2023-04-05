//
//  UserInfoVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 25.03.2023.
//

import UIKit

class UserInfoVC: UIViewController {

  private enum Cons {
    static let datePlaceholder: String = "{date}"
  }
  
  private enum Layout {
    static let padding: CGFloat = 20
    static let headerHeight: CGFloat = 180
    static let itemHeigh: CGFloat = 140
    static let dateHeight: CGFloat = 18
  }

  private let headerView = UIView()
  private let itemViewOne = UIView()
  private let itemViewTwo = UIView()
  private let dateLabel = GFBodyLabel(textAligment: .center)

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
    let subViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
    for itemView in subViews {
      view.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false

      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.padding),
        itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.padding)
      ])
    }

    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.heightAnchor.constraint(equalToConstant: Layout.headerHeight),

      itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Layout.padding),
      itemViewOne.heightAnchor.constraint(equalToConstant: Layout.itemHeigh),

      itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: Layout.padding),
      itemViewTwo.heightAnchor.constraint(equalToConstant: Layout.itemHeigh),

      dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: Layout.padding),
      dateLabel.heightAnchor.constraint(equalToConstant: Layout.dateHeight)
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
          self.add(childVC: GFRepoItemVC(user: user), to: self.itemViewOne)
          self.add(childVC: GFFollowerItemVC(user: user), to: self.itemViewTwo)
          self.dateLabel.text = Constants.Texts.githubSinceWithDate
            .replacingOccurrences(of: Cons.datePlaceholder,
                                  with: user.createdAt.convertToDisplayFormat())
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
