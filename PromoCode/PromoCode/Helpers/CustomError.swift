//
//  CustomError.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//

import Foundation

enum СustomError: String, Error {
    case error = "Ошика ☹️"
    case unexpected = "Неизвестная ошибка 🤔"
    case failedToAddPromocode = "Эта почта уже занята или некорректна 🤷‍♀️"
    case failedFindingPromocodes = "Не удалось найти промокоды 🤷‍♀️"
}
