//
//  UIView+Extension.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 9.04.2023.
//

import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    for view in views {
      addSubview(view)
    }
  }
  
  func pinToSuperView() {
    guard let superView = self.superview else { return }
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: superView.topAnchor),
      leadingAnchor.constraint(equalTo: superView.leadingAnchor),
      trailingAnchor.constraint(equalTo: superView.trailingAnchor),
      bottomAnchor.constraint(equalTo: superView.bottomAnchor)
    ])
  }
}

