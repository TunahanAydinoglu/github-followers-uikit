//
//  FavoriteCell.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 8.04.2023.
//

import UIKit

class FavoriteCell: UITableViewCell {
  static let reuseId = "FavoriteCell"
  
  private enum Layout {
    static let padding: CGFloat = 12
    static let labelFontSize: CGFloat = 26
    static let labelHeight: CGFloat = 40
    static let imageSize: CGFloat = 60
    static let spacing: CGFloat = 24
  }
  
  let avatarImageView = GFAvatarImageView(frame: .zero)
  let usernameLabel = GFTitleLabel(textAligment: .left, fontSize: Layout.labelFontSize)
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func set(favorite: Follower){
    usernameLabel.text = favorite.login
    downloadImage(avatarUrl: favorite.avatarUrl)
  }
  
  private func configure() {
    addSubview(avatarImageView)
    addSubview(usernameLabel)
    accessoryType = .disclosureIndicator
    
    NSLayoutConstraint.activate([
      avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.padding),
      avatarImageView.heightAnchor.constraint(equalToConstant: Layout.imageSize),
      avatarImageView.widthAnchor.constraint(equalToConstant: Layout.imageSize),
      
      usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      usernameLabel.leadingAnchor.constraint(
        equalTo: avatarImageView.trailingAnchor,
        constant: Layout.spacing),
      usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.padding),
      usernameLabel.heightAnchor.constraint(equalToConstant: Layout.labelHeight)
    ])
  }
}

private extension FavoriteCell {
  func downloadImage(avatarUrl: String) {
    NetworkManager.shared.downloadImage(from: avatarUrl) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.avatarImageView.image = image
      }
    }
  }
}
