//
//  PromoCode.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//

import Foundation

enum Spheres: String, CaseIterable {
    case films
    case food
    case clothes
    case travelling
    case games
    case others
    
    func inRussian() -> String {
        switch self {
        case .films:
            return "Фильмы"
        case .food:
            return "Еда"
        case .clothes:
            return "Одежда"
        case .travelling:
            return "Путешествия"
        case .games:
            return "Игры"
        default:
            return "Другое"
        }
    }
}

struct PromoCode {
    var id: String = ""
    var service: String = ""
    var promocode: String = ""
    var description: String = ""
    var date: Date = Date()
    var isInFavorites: Bool = false
}
