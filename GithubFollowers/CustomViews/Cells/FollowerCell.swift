//
//  CollectionViewCell.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 25.11.2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
  static let reuseId = "FollowerCell"

  private enum Layout {
    static let padding: CGFloat = 8.0
    static let labelFontSize: CGFloat = 16
    static let labelTop: CGFloat = 12
    static let labelHeight: CGFloat = 20
  }

  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAligment: .center, fontSize: Layout.labelFontSize)

  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init coder :)")
  }

  func set(follower: Follower){
    usernameLabel.text = follower.login
    downloadImage(avatarUrl: follower.avatarUrl)
  }

  private func configure() {
    addSubview(avatarImageView)
    addSubview(usernameLabel)

    NSLayoutConstraint.activate([
      avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Layout.padding),
      avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.padding),
      avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.padding),
      avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

      usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: Layout.labelTop),
      usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Layout.padding),
      usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Layout.padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: Layout.labelHeight)
    ])
  }
}

private extension FollowerCell {
  func downloadImage(avatarUrl: String) {
    NetworkManager.shared.downloadImage(from: avatarUrl) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.avatarImageView.image = image
      }
    }
  }
}
