//
//  GFUserInfoVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 2.04.2023.
//

import UIKit

class GFUserInfoVC: UIViewController {

  private let avatarImageView = GFAvatarImageView(frame: .zero)
  private let userNameLabel = GFTitleLabel(textAligment: .left, fontSize: 34)
  private let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
  private let locationImageView = UIImageView()
  private let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
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
    downloadImage(avatarUrl: user.avatarUrl)
    userNameLabel.text = user.login
    nameLabel.text = user.name ?? Constants.Texts.emptyString
    locationLabel.text = user.location ?? Constants.Texts.noLocation
    bioLabel.text = user.bio ?? Constants.Texts.noBioAvailable
    bioLabel.numberOfLines = 3

    locationImageView.image = Images.locationPin
    locationImageView.tintColor = .secondaryLabel
  }

  private func addSubviews() {
    view.addSubview(avatarImageView)
    view.addSubview(userNameLabel)
    view.addSubview(nameLabel)
    view.addSubview(locationImageView)
    view.addSubview(locationLabel)
    view.addSubview(bioLabel)
  }

  private func layoutUI() {
    let padding: CGFloat = 20
    let textImagePadding : CGFloat = 12
    locationImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
      avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      avatarImageView.widthAnchor.constraint(equalToConstant: 90),
      avatarImageView.heightAnchor.constraint(equalToConstant: 90),

      userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
      userNameLabel.leadingAnchor.constraint(
        equalTo: avatarImageView.trailingAnchor,
        constant: textImagePadding
      ),
      userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      userNameLabel.heightAnchor.constraint(equalToConstant: 38),

      nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
      nameLabel.leadingAnchor.constraint(
        equalTo: avatarImageView.trailingAnchor,
        constant: textImagePadding
      ),
      nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: 20),

      locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
      locationImageView.leadingAnchor.constraint(
        equalTo: avatarImageView.trailingAnchor,
        constant: textImagePadding
      ),
      locationImageView.heightAnchor.constraint(equalToConstant: 20),
      locationImageView.widthAnchor.constraint(equalToConstant: 20),

      locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
      locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
      locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      locationLabel.heightAnchor.constraint(equalToConstant: 20),

      bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
      bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
      bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      bioLabel.heightAnchor.constraint(equalToConstant: 60)
    ])
  }
}

private extension GFUserInfoVC {
  func downloadImage(avatarUrl: String) {
    NetworkManager.shared.downloadImage(from: avatarUrl) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.avatarImageView.image = image
      }
    }
  }
}
