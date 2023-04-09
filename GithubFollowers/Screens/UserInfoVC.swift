//
//  UserInfoVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 25.03.2023.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
  func didRequestFollowers(for username: String)
}

class UserInfoVC: UIViewController {
  private enum Cons {
    static let datePlaceholder: String = "{date}"
  }
  
  private enum Layout {
    static let padding: CGFloat = 20
    static let headerHeight: CGFloat = 210
    static let itemHeigh: CGFloat = 140
    static let dateHeight: CGFloat = 50
    static let contentHeight: CGFloat = headerHeight + 2*itemHeigh + dateHeight + 5*padding
  }

  let scrollView = UIScrollView()
  let contentView = UIView()
  
  private let headerView = UIView()
  private let itemViewOne = UIView()
  private let itemViewTwo = UIView()
  private let dateLabel = GFBodyLabel(textAligment: .center)
  
  var userName: String = Constants.Texts.emptyString
  weak var delegate: UserInfoVCDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureViewContoller()
    configureScrollView()
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

  private func configureScrollView() {
    view.addSubview(scrollView)
    scrollView.pinToSuperView()

    scrollView.addSubview(contentView)
    contentView.pinToSuperView()

    NSLayoutConstraint.activate([
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      contentView.heightAnchor.constraint(equalToConstant: Layout.contentHeight)
    ])
  }
  
  private func configureUIElements(with user: User){
    self.add(childVC: GFRepoItemVC(user: user, delegate: self), to: self.itemViewOne)
    self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
    self.dateLabel.text = Constants.Texts.githubSinceWithDate
      .replacingOccurrences(of: Cons.datePlaceholder,
                            with: user.createdAt.convertToMonthYearFormat())
  }
  
  private func layoutUI() {
    let subViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
    for itemView in subViews {
      contentView.addSubview(itemView)
      itemView.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.padding),
        itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.padding)
      ])
    }
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
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

extension UserInfoVC: GFRepoItemVCDelegate {
  func didTapGithubProfile(for user: User) {
    guard let url = URL(string: user.htmlUrl) else {
      presentGFAlertOnMainThread(
        title: Constants.Texts.invalidUrl,
        message: Constants.Errors.userUrlNotValid,
        buttonTitle: Constants.Texts.ok
      )
      return
    }
    
    presentSafariVC(with: url)
  }
}

extension UserInfoVC: GFFollowerItemVCDelegate {
  func didTapGetFollowers(for user: User) {
    guard user.followers != 0 else {
      presentGFAlertOnMainThread(
        title: Constants.Texts.noFollowers,
        message: Constants.Errors.emptyFollowers,
        buttonTitle: Constants.Texts.ok
      )
      return
    }
    delegate?.didRequestFollowers(for: user.login)
    dismissVC()
  }
} 

// MARK: Network
private extension UserInfoVC {
  func getUserInfo() {
    NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
      guard let self = self else { return }
      
      switch result {
      case .success(let user):
        DispatchQueue.main.async {
          self.configureUIElements(with: user)
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
