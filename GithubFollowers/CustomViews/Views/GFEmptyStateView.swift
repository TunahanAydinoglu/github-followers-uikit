//
//  GFEmptyStateViewi.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 25.03.2023.
//

import UIKit

class GFEmptyStateView: UIView {
  private enum Layout {
    static let messageHeight: CGFloat = 200
    static let messageLeadingAndTrailing: CGFloat = 40
    static let messageTop: CGFloat = DeviceTypes.isSmallScreen ? 80 : 150

    static let logoBottom: CGFloat = DeviceTypes.isSmallScreen ? 80 : 40
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

  convenience init(message: String){
    self.init(frame: .zero)
    messageLabel.text = message
  }
  
  private func configure() {
    configureMassageLabel()
    configureLogoImageView()
  }

  private func configureLogoImageView() {
    addSubview(logoImageView)
    logoImageView.image = Images.emptyStateLogo
    logoImageView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
      logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
      logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: Layout.logoTrailing),
      logoImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: Layout.logoBottom)
    ])
  }

  private func configureMassageLabel() {
    addSubview(messageLabel)
    messageLabel.numberOfLines = 3
    messageLabel.textColor = .secondaryLabel

    NSLayoutConstraint.activate([
      messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant:  -Layout.messageTop),
      messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Layout.messageLeadingAndTrailing),
      messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Layout.messageLeadingAndTrailing),
      messageLabel.heightAnchor.constraint(equalToConstant: Layout.messageHeight)
    ])
  }
}
