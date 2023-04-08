//
//  FavoritesListVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 18.10.2022.
//

import Foundation
import UIKit

class FavoritesListVC: UIViewController {
  private enum Layout {
    static let cellHeight: CGFloat = 80
  }
  
  let tableView = UITableView()
  var favorites: [Follower] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemPink
    
    configureViewController()
    configureTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getFavorites()
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    title = Constants.Texts.favorites
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func configureTableView() {
    view.addSubview(tableView)
    
    tableView.frame = view.bounds
    tableView.rowHeight = Layout.cellHeight
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
  }
  
  private func getFavorites() {
    PersistenceManager.retrieveFavorites { [weak self] result in
      guard let self = self else { return }
      switch result {
      case .success(let favorites):
        if favorites.isEmpty {
          self.showEmptyStateView(with: Constants.Texts.noFavorites, in: self.view)
        } else {
          self.favorites = favorites
          DispatchQueue.main.async {
            self.tableView.reloadData()
            self.view.bringSubviewToFront(self.tableView)
          }
        }
        
      case .failure(let err):
        self.presentGFAlertOnMainThread(
          title: Constants.Errors.smtError,
          message: err.rawValue,
          buttonTitle: Constants.Texts.ok
        )
      }
    }
  }
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard
      let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId) as? FavoriteCell
    else {
      return UITableViewCell()
    }
    let favorite = self.favorites[indexPath.row]
    cell.set(favorite: favorite)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let favorite = favorites[indexPath.row]
    let destVC = FollowerListVC(username: favorite.login)
    
    navigationController?.pushViewController(destVC, animated: true)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else { return }
    
    let favorite = favorites[indexPath.row]
    favorites.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .left)
    PersistenceManager.update(with: favorite, actionType: .remove) { [weak self] error in
      guard let self = self else { return }
      
      if let error = error {
        self.presentGFAlertOnMainThread(
          title: Constants.Errors.unableRemove,
          message: error.rawValue,
          buttonTitle: Constants.Texts.ok
        )
      }
    }
  }
}
