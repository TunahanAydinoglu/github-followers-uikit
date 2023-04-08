//
//  GFTextField.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 18.10.2022.
//

import UIKit

class GFTextField: UITextField {
  private enum Layout {
    static let radius: CGFloat = 10
    static let borderWidth: CGFloat = 2
    static let minFontSize: CGFloat = 12
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func configure(){
    translatesAutoresizingMaskIntoConstraints = false
    
    layer.cornerRadius = Layout.radius
    layer.borderWidth = Layout.borderWidth
    layer.borderColor = UIColor.systemGray4.cgColor
    
    textColor = .label
    tintColor = .label
    textAlignment = .center
    font = UIFont.preferredFont(forTextStyle: .title2)
    adjustsFontSizeToFitWidth = true
    minimumFontSize = Layout.minFontSize
    
    backgroundColor = .tertiarySystemBackground
    autocorrectionType = .no
    returnKeyType = .go
    clearButtonMode = .whileEditing
    
    placeholder = Constants.Texts.usernamePlaceholder
  }
  
}
