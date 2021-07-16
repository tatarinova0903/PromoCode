//
//  String + Extension.swift
//  PromoCode
//
//  Created by Дарья on 16.07.2021.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd.MM.yyyy"
        return dateformatter.date(from: self)
    }
}
