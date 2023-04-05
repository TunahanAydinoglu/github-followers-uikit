//
//  Date+Extension.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 5.04.2023.
//

import Foundation

extension Date {

  func convertToMonthYearFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM yyyy"
    return dateFormatter.string(from: self)
  }
}
