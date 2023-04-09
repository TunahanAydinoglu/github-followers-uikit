//
//  GFAvatarImageView.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 25.11.2022.
//

import UIKit

class GFAvatarImageView: UIImageView {

	let cache = NetworkManager.shared.cache
  let placeHolderImage = Images.avatarPlaceholder

	override init(frame: CGRect) {
		super.init(frame: frame)
		configure()
	}

	required init?(coder: NSCoder) {
		fatalError("init coder:) has not implemented")
	}

	private func configure() {
		layer.cornerRadius = 10
		clipsToBounds = true
		image = placeHolderImage
		widthAnchor.constraint(equalToConstant: 90).isActive = true
		translatesAutoresizingMaskIntoConstraints = false
	}

  func downloadImage(from url: String) {
    NetworkManager.shared.downloadImage(from: url) { [weak self] image in
      guard let self = self else { return }
      DispatchQueue.main.async { self.image = image }
    }
  }
}
