//
//  GFItemInfoVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 4.04.2023.
//

import UIKit

class GFItemInfoVC: UIViewController {

  private enum Layout {
    static let padding: CGFloat = 20
    static let stackViewHeigh: CGFloat = 50
    static let actionButtonHeight: CGFloat = 44
  }

  let stackView = UIStackView()
  let itemInfoViewLeading = GFItemInfoView()
  let itemInfoViewTrailing = GFItemInfoView()
  let actionButton = GFButton()

  var user: User
  weak var delegate: UserInfoVCDelegate?

  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureBackgroundView()
    configureActionButton()
    layoutUI()
    configureStackView()
  }

  private func configureActionButton() {
    actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
  }

  @objc func actionButtonTapped() {}

  private func configureStackView() {
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing

    stackView.addArrangedSubview(itemInfoViewLeading)
    stackView.addArrangedSubview(itemInfoViewTrailing)
  }

  private func configureBackgroundView() {
    view.layer.cornerRadius = 18
    view.backgroundColor = .secondarySystemBackground
  }

  private func layoutUI() {
    view.addSubview(stackView)
    view.addSubview(actionButton)

    stackView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.padding),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.padding),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.padding),
      stackView.heightAnchor.constraint(equalToConstant: Layout.stackViewHeigh),

      actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Layout.padding),
      actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.padding),
      actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.padding),
      actionButton.heightAnchor.constraint(equalToConstant: Layout.actionButtonHeight)
    ])
  }
}
