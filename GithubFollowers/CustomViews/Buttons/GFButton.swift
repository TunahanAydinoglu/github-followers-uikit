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

  init(backgroundColor: UIColor, title:String){
    super.init(frame: .zero)
    configure()
    self.backgroundColor = backgroundColor
    self.setTitle(title, for: .normal)
  }

  func set(backgroundColor: UIColor, title: String) {
    self.backgroundColor = backgroundColor
    setTitle(title, for: .normal)
  }

  private func configure(){
    layer.cornerRadius = 10
    setTitleColor(.white, for: .normal)
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    translatesAutoresizingMaskIntoConstraints = false
  }

}
