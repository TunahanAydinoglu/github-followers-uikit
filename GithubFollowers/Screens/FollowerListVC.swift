//
//  FollowerListVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 20.10.2022.
//

import UIKit

class FollowerListVC: UIViewController {
  
  enum Section {
    case main
  }
  
  var username: String!
  var followers: [Follower] = []
  var filteredFollowers: [Follower] = []
  var page: Int = 1
  var isLastPage = false
  var isSearching: Bool { !filteredFollowers.isEmpty }
  
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    configureSearchController()
    configureCollectionView()
    getFollowers(username: username, page: page)
    configureDataSource()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
  }
  
  func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    searchController.searchBar.placeholder = Constants.Texts.searchPlaceholder
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }
  
  func getFollowers(username: String, page: Int) {
    showLoadingView()
    NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
      self?.dismissLoadingView()
      guard let self = self else { return }
      switch result {
      case .success(let followers):
        print("Followers.count = \(followers.count)")
        if followers.count < NetworkManager.perPageCount {
          self.isLastPage = true
        }
        self.followers.append(contentsOf: followers)
        if self.followers.isEmpty {
          let message = Constants.Errors.emptyFollowers
          DispatchQueue.main.async {
            self.showEmptyStateView(with: message, in: self.view)
          }
          return
        }
        self.updateData(on: self.followers)
        
      case .failure(let error):
        self.presentGFAlertOnMainThread(title: Constants.Errors.badStuff, message: error.rawValue, buttonTitle: Constants.Texts.ok)
      }
    }
  }
  
  func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
      collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
        cell.set(follower: follower)
        return cell
      })
  }
  
  func updateData(on followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
    DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
  }
}


extension FollowerListVC: UICollectionViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height
    
    if offsetY > contentHeight - (height + 95) {
      if isLastPage { return }
      page = page + 1
      getFollowers(username: username, page: page)
    }
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let follower = isSearching
    ? filteredFollowers[indexPath.item]
    : followers[indexPath.item]

    let destVc = UserInfoVC()
    destVc.userName = follower.login
    let navController = UINavigationController(rootViewController: destVc)
    present(navController, animated: true)
  }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text else { return }
    if filter.isEmpty {
      filteredFollowers = []
      updateData(on: followers)
      return
    }
    filteredFollowers = followers
      .filter{$0.login.lowercased().contains(filter.lowercased())}
    updateData(on: filteredFollowers)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    updateData(on: followers)
  }
}
