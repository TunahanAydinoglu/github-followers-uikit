//
//  GFBodyLabel.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 27.10.2022.
//

import UIKit

class GFBodyLabel: UILabel {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(
    textAligment: NSTextAlignment
  ){
    self.init(frame: .zero)
    self.textAlignment = textAligment
  }
  
  private func configure(){
    textColor = .secondaryLabel
    font = UIFont.preferredFont(forTextStyle: .body)
    adjustsFontForContentSizeCategory = true
    adjustsFontSizeToFitWidth = true
    minimumScaleFactor = 0.75
    lineBreakMode = .byWordWrapping
    translatesAutoresizingMaskIntoConstraints = false
  }
  
}
