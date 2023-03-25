//
//  GFAvatarImageView.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 25.11.2022.
//

import UIKit

class GFAvatarImageView: UIImageView {

	let cache = NetworkManager.shared.cache
  let placeHolderImage = UIImage(named: Constants.Images.avatarPlaceHolder)!

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

	func downloadImage(from urlString: String) {
		let cacheKey = NSString(string: urlString)
		if let image = cache.object(forKey: cacheKey) {
			self.image = image
			return
		}
		
		guard let url = URL(string: urlString) else { return }

		let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, err in
			guard let self = self, err == nil else { return }

			guard let response = response as? HTTPURLResponse,
						response.statusCode == 200,
						let data = data
			else { return }

			guard let image = UIImage(data: data) else { return }

			self.cache.setObject(image, forKey: cacheKey)
			DispatchQueue.main.async {
				self.image = image
			}
		}
		task.resume()
	}

}
