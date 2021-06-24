//
//  FavoritesInteractor.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

final class FavoritesInteractor {
    weak var output: FavoritesInteractorOutput?
    
    let data: [PromoCode] = [PromoCode(sphere: .films, service: "Кинопоиск", promocode: "34RFGDTDT", description: "Описание",                          date: Date()),
                             PromoCode(sphere: .films,service: "Амедиатека", promocode: "GTD45DYR", description: "Описание", date: Date()),
                             PromoCode(sphere: .films, service: "Нетфликс", promocode: "76YFYTF34", description: "Описание", date: Date()),
                             PromoCode(sphere: .food, service: "БургерКинг", promocode: "YFRGY65GE", description: "Описание", date: Date())]
}

extension FavoritesInteractor: FavoritesInteractorInput {
    
    func getDataCount() -> Int {
        data.count
    }
    
    func getPromoCode(forIndex index: Int) -> PromoCode {
        data[index]
    }
}
