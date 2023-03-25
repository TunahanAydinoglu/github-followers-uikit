//
//  GFEmptyStateViewi.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 25.03.2023.
//

import UIKit

class GFEmptyStateView: UIView {

  private enum Constants {
    static let emptyStateLogoName: String = "empty-state-logo"
  }

  private enum Layout {
    static let messageHeight: CGFloat = 200
    static let messageLeadingAndTrailing: CGFloat = 40
    static let messageTop: CGFloat = 150

    static let logoBottom: CGFloat = 40
    static let logoTrailing: CGFloat = 170

  }

  let messageLabel = GFTitleLabel(textAligment: .center, fontSize: 28)
  let logoImageView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)

    configure()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  init(message: String){
    super.init(frame: .zero)
    messageLabel.text = message
    configure()
  }

  private func configure() {
    addSubview(messageLabel)
    addSubview(logoImageView)

    messageLabel.numberOfLines = 3
    messageLabel.textColor = .secondaryLabel

    logoImageView.image = UIImage(named: Constants.emptyStateLogoName)
    logoImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(
        equalTo: self.centerYAnchor, constant:  -Layout.messageTop),
      messageLabel.leadingAnchor.constraint(
        equalTo: self.leadingAnchor, constant: Layout.messageLeadingAndTrailing),
      messageLabel.trailingAnchor.constraint(
        equalTo: self.trailingAnchor, constant: -Layout.messageLeadingAndTrailing),
      messageLabel.heightAnchor.constraint(equalToConstant: Layout.messageHeight),

      logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
      logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
      logoImageView.trailingAnchor.constraint(
        equalTo: self.trailingAnchor, constant: Layout.logoTrailing),
      logoImageView.bottomAnchor.constraint(
        equalTo: self.bottomAnchor, constant: Layout.logoBottom)
    ])
  }

}
