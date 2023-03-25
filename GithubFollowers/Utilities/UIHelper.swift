//
//  UIHelper.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 12.01.2023.
//

import UIKit

class UIHelper {
	static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
		let width = view.bounds.width
		let padding: CGFloat = 12.0
		let minumumItemSpacing: CGFloat = 10.0
		let availableWidth = width - (padding * 2) - (minumumItemSpacing * 2)
		let itemWidth = availableWidth / 3

		let flowLayout = UICollectionViewFlowLayout()
		flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
		flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

		return flowLayout
	}
}
