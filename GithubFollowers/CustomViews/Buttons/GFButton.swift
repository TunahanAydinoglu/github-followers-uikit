//
//  GFButton.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 18.10.2022.
//

import UIKit

class GFButton: UIButton {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  convenience init(backgroundColor: UIColor, title:String){
    self.init(frame: .zero)
    set(backgroundColor: backgroundColor, title: title)
  }
  
  final func set(backgroundColor: UIColor, title: String) {
    configuration?.baseBackgroundColor = backgroundColor
    configuration?.baseForegroundColor = .white
    configuration?.title = title
  }
  
  private func configure(){
    configuration = .filled()
    configuration?.cornerStyle = .medium
    translatesAutoresizingMaskIntoConstraints = false
  }

}
