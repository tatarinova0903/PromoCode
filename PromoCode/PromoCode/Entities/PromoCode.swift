//
//  PromoCode.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//

import Foundation

enum Spheres: String {
    case films
    case food
    case games
    case others
}

struct PromoCode {
    var id: String = ""
    var service: String = ""
    var promocode: String = ""
    var description: String = ""
    var date: Date = Date()
}
