//
//  FollowerListVC.swift
//  github-followers
//
//  Created by Tunahan Aydınoğlu on 20.10.2022.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
  enum Section {
    case main
  }
  
  var username: String = Constants.Texts.emptyString
  var followers: [Follower] = []
  var filteredFollowers: [Follower] = []
  var pageIndex: Int = 1
  var isLastPage = false
  var isSearching: Bool { !filteredFollowers.isEmpty }
  
  var collectionView: UICollectionView!
  var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
  
  init(username: String){
    super.init(nibName: nil, bundle: nil)
    self.username = username
    title = username
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureViewController()
    configureSearchController()
    configureCollectionView()
    getFollowers(username: username, page: pageIndex)
    configureDataSource()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: true)
  }
  
  private func configureViewController() {
    view.backgroundColor = .systemBackground
    navigationController?.navigationBar.prefersLargeTitles = true
    let addButton = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addButtonTapped)
    )
    navigationItem.rightBarButtonItem = addButton
  }
  
  private func configureCollectionView() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
    view.addSubview(collectionView)
    collectionView.delegate = self
    collectionView.backgroundColor = .systemBackground
    collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
  }
  
  private func configureSearchController() {
    let searchController = UISearchController()
    searchController.searchResultsUpdater = self
    searchController.searchBar.placeholder = Constants.Texts.searchPlaceholder
    searchController.obscuresBackgroundDuringPresentation = false
    navigationItem.searchController = searchController
  }
  
  private func getFollowers(username: String, page: Int) {
    showLoadingView()
    
    Task {
      do {
        let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
        self.updateUI(with: followers)
        dismissLoadingView()
      } catch {
        guard let gfError = error as? GFError else {
          self.presentDefaultError()
          return
        }
        self.presentGFAlert(
          title: Constants.Errors.badStuff,
          message: gfError.rawValue,
          buttonTitle: Constants.Texts.ok
        )
        dismissLoadingView()
      }
      
      //      guard let followers = try? await NetworkManager.shared.getFollowers(for: username, page: page) else {
      //        presentDefaultError()
      //        dismissLoadingView()
      //        return
      //      }
      //
      //      updateUI(with: followers)
      //      dismissLoadingView()
    }
  }
  
  private func updateUI(with followers: [Follower]) {
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
  }
  
  private func configureDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, Follower>(
      collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
        cell.set(follower: follower)
        return cell
      })
  }
  
  private func updateData(on followers: [Follower]) {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems(followers)
    DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
  }
  
  @objc func addButtonTapped() {
    showLoadingView()
    Task {
      do {
        let user = try await NetworkManager.shared.getUserInfo(for: username)
        addUserToFavorites(user: user)
        dismissLoadingView()
      } catch {
        dismissLoadingView()
        guard let gfError = error as? GFError else {
          presentDefaultError()
          return
        }
        presentGFAlert(
          title: Constants.Errors.smtError,
          message: gfError.rawValue,
          buttonTitle: Constants.Texts.ok
        )
      }
    }
  }
  
  private func addUserToFavorites(user: User) {
    let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
    
    PersistenceManager.update(with: favorite, actionType: .add) { [weak self] err in
      guard let self = self else { return }
      if let err = err {
        self.presentGFAlertOnMainThread(
          title: Constants.Errors.smtError,
          message: err.rawValue,
          buttonTitle: Constants.Texts.ok
        )
      }
      self.presentGFAlertOnMainThread(
        title: Constants.Texts.success,
        message: Constants.Texts.succeededFavorie,
        buttonTitle: Constants.Texts.ok
      )
    }
  }
}


extension FollowerListVC: UICollectionViewDelegate {
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let offsetY = scrollView.contentOffset.y
    let contentHeight = scrollView.contentSize.height
    let height = scrollView.frame.size.height
    
    if offsetY > contentHeight - (height + 95) {
      if isLastPage { return }
      pageIndex = pageIndex + 1
      getFollowers(username: username, page: pageIndex)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let follower = isSearching
    ? filteredFollowers[indexPath.item]
    : followers[indexPath.item]
    
    let destVc = UserInfoVC()
    destVc.username = follower.login
    destVc.delegate = self
    let navController = UINavigationController(rootViewController: destVc)
    present(navController, animated: true)
  }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
  func updateSearchResults(for searchController: UISearchController) {
    guard let filter = searchController.searchBar.text, !filter.isEmpty
    else {
      filteredFollowers.removeAll()
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

extension FollowerListVC: UserInfoVCDelegate {
  func didRequestFollowers(for username: String) {
    self.username = username
    title = username
    pageIndex = 1
    
    followers.removeAll()
    filteredFollowers.removeAll()
    getFollowers(username: username, page: pageIndex)
    collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
    collectionView.layoutIfNeeded()
  }
}
