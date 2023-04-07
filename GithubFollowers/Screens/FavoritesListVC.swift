//
//  FavoritesListVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 18.10.2022.
//

import Foundation
import UIKit

class FavoritesListVC: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemPink

    PersistenceManager.retrieveFavorites { result in
      switch result {
      case .success(let followers):
				print(followers)
      case .failure(let err):
        print(err.rawValue)
      }
    }
  }

}
