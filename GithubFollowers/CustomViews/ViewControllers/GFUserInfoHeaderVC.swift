//
//  GFUserInfoHeaderVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 2.04.2023.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

  private enum Layout {
    static let padding: CGFloat = 20
    static let textImagePadding : CGFloat = 12
    static let labelsFontSize: CGFloat = 18
    static let bioLabelNumberOfLines: Int = 3
    static let avatarImageSize: CGFloat = 90
    static let usernameLabelHeight: CGFloat = 38
    static let nameLabelYPadding: CGFloat = 8
    static let nameLabelHeigh: CGFloat = 20
    static let locationImageSize: CGFloat = 20
    static let locationImageTrailingPadding: CGFloat = 5
    static let locationLabelHeigh: CGFloat = 20
    static let bioLabelHeight: CGFloat = 90
  }

  private let avatarImageView = GFAvatarImageView(frame: .zero)
  private let userNameLabel = GFTitleLabel(textAligment: .left, fontSize: 34)
  private let nameLabel = GFSecondaryTitleLabel(fontSize: Layout.labelsFontSize)
  private let locationImageView = UIImageView()
  private let locationLabel = GFSecondaryTitleLabel(fontSize: Layout.labelsFontSize)
  private let bioLabel = GFBodyLabel(textAligment: .left)

  private let user: User

  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    layoutUI()
    configureUI()
  }

  private func configureUI() {
    avatarImageView.downloadImage(from: user.avatarUrl)
    userNameLabel.text = user.login
    nameLabel.text = user.name ?? Constants.Texts.emptyString
    locationLabel.text = user.location ?? Constants.Texts.noLocation
    bioLabel.text = user.bio ?? Constants.Texts.noBioAvailable
    bioLabel.numberOfLines = Layout.bioLabelNumberOfLines

    locationImageView.image = Images.locationPin
    locationImageView.tintColor = .secondaryLabel
  }

  private func addSubviews() {
    view.addSubviews(
      avatarImageView,
      userNameLabel,
      nameLabel,
      locationImageView,
      locationLabel,
      bioLabel
    )
  }

  private func layoutUI() {
    locationImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.padding),
      avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      avatarImageView.widthAnchor.constraint(equalToConstant: Layout.avatarImageSize),
      avatarImageView.heightAnchor.constraint(equalToConstant: Layout.avatarImageSize),

      userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
      userNameLabel.leadingAnchor.constraint(
        equalTo: avatarImageView.trailingAnchor,
        constant: Layout.textImagePadding
      ),
      userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      userNameLabel.heightAnchor.constraint(equalToConstant: Layout.usernameLabelHeight),

      nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: Layout.nameLabelYPadding),
      nameLabel.leadingAnchor.constraint(
        equalTo: avatarImageView.trailingAnchor,
        constant: Layout.textImagePadding
      ),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: Layout.nameLabelHeigh),

      locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
      locationImageView.leadingAnchor.constraint(
        equalTo: avatarImageView.trailingAnchor,
        constant: Layout.textImagePadding
      ),
      locationImageView.heightAnchor.constraint(equalToConstant: Layout.locationImageSize),
      locationImageView.widthAnchor.constraint(equalToConstant: Layout.locationImageSize),

      locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: Layout.locationImageTrailingPadding),
      locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      locationLabel.heightAnchor.constraint(equalToConstant: Layout.locationLabelHeigh),

      bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Layout.textImagePadding),
      bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
      bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bioLabel.heightAnchor.constraint(equalToConstant: Layout.bioLabelHeight)
    ])
  }
}
