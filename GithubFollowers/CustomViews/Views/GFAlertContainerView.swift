//
//  GFAlertContainerView.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 8.04.2023.
//

import UIKit

class GFAlertContainerView: UIView {
  
  private enum Layout {
    static let containerRadius: CGFloat = 16
    static let containerBorderWidth: CGFloat = 2
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    backgroundColor = .systemBackground
    layer.cornerRadius = Layout.containerRadius
    layer.borderWidth = Layout.containerBorderWidth
    layer.borderColor = UIColor.white.cgColor
    translatesAutoresizingMaskIntoConstraints = false
  }
}
