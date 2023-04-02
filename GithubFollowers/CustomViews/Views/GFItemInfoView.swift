//
//  GFItemInfoView.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 2.04.2023.
//

import UIKit

enum ItemInfoType {
  case repos, gists, followers, following
}

class GFItemInfoView: UIView {
  
  private enum Layout {
    static let imageWidth: CGFloat = 20
    static let imageHeight: CGFloat = 20
    static let spacing: CGFloat = 12
    static let titleHeight: CGFloat = 18
  }
  
  private let symbolImageView = UIImageView()
  private let titleLabel = GFTitleLabel(textAligment: .left, fontSize: 14)
  private let countLabel = GFTitleLabel(textAligment: .center, fontSize: 14)
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    configure()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    addSubview(symbolImageView)
    addSubview(titleLabel)
    addSubview(countLabel)
    
    symbolImageView.translatesAutoresizingMaskIntoConstraints = false
    symbolImageView.contentMode = .scaleAspectFill
    symbolImageView.tintColor = .label
    
    NSLayoutConstraint.activate([
      symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
      symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      symbolImageView.widthAnchor.constraint(equalToConstant: Layout.imageWidth),
      symbolImageView.heightAnchor.constraint(equalToConstant: Layout.imageHeight),
      
      titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: Layout.spacing),
      titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      titleLabel.heightAnchor.constraint(equalToConstant: Layout.titleHeight),
      
      countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
      countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      countLabel.heightAnchor.constraint(equalToConstant: Layout.titleHeight)
    ])
  }
  
  func set(for itemInfoType: ItemInfoType, with count: Int){
    switch itemInfoType {
    case .repos:
      symbolImageView.image = UIImage(systemName: Constants.Images.folder)
      titleLabel.text = Constants.Texts.publicRepos
    case .gists:
      symbolImageView.image = UIImage(systemName: Constants.Images.folder)
      titleLabel.text = Constants.Texts.publicGists
    case .followers:
      symbolImageView.image = UIImage(systemName: Constants.Images.folder)
      titleLabel.text = Constants.Texts.followers
    case .following:
      symbolImageView.image = UIImage(systemName: Constants.Images.folder)
      titleLabel.text = Constants.Texts.following
    }
    
    countLabel.text = String(count)
  }
}
