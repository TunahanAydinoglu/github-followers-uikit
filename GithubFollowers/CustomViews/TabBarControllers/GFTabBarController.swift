//
//  GFTabBarController.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 8.04.2023.
//

import UIKit

class GFTabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

		configurator()
  }

  private func configurator() {
    UITabBar.appearance().tintColor = .systemGreen
    UITabBar.appearance().backgroundColor = .systemBackground

    viewControllers = [createSearchNC(), createFavoritesNC()]
  }

  private func createSearchNC() -> UINavigationController {
    let searchVC = SearchVC()
    searchVC.title = Constants.Texts.search
    searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

    return UINavigationController(rootViewController: searchVC)
  }

  private func createFavoritesNC() -> UINavigationController {
    let favoritesListVC = FavoritesListVC()
    favoritesListVC.title = Constants.Texts.favorites
    favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

    return UINavigationController(rootViewController: favoritesListVC)
  }
}
