//
//  String+Extension.swift
//  github-followers
//
//  Created by Tunahan Aydınoglu on 5.04.2023.
//

import Foundation

extension String {

  func convertToDate() -> Date? {
		let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_US")
    dateFormatter.timeZone = .current
    return dateFormatter.date(from: self)
  }

  func convertToDisplayFormat() -> String {
    guard let date = self.convertToDate() else { return "N/A" }
    return date.convertToMonthYearFormat()
  }
}
