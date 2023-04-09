//
//  UITableView+Extension.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 9.04.2023.
//

import UIKit

extension UITableView {

  func reloadDataOnMainThread() {
    DispatchQueue.main.async { self.reloadData() }
  }

  func removeExcessCells() {
    tableFooterView = UIView(frame: .zero)
  }
}
