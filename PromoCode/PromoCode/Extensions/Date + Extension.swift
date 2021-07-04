//
//  UIDate + Extension.swift
//  PromoCode
//
//  Created by Дарья on 04.07.2021.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd.MM.yyyy"
        return dateformatter.string(from: self)
    }
}
