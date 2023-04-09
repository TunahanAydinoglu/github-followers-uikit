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
}

