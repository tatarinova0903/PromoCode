//
//  PromoCode.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//

import Foundation

enum Spheres: String {
    case films = "Кино"
    case food = "Еда"
    case games = "Игры"
    case others = "Другое"
}

struct PromoCode {
    var service: String = ""
    var promocode: String = ""
    var description: String = ""
    var date: Date = Date()
}
