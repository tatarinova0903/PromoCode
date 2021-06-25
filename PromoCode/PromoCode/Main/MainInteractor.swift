//
//  MainInteractor.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

final class MainInteractor {
	weak var output: MainInteractorOutput?
    
    let data: [PromoCode] = [PromoCode(service: "Кинопоиск", promocode: "34RFGDTDT", description: "Описание",                          date: Date()),
                             PromoCode(service: "Амедиатека", promocode: "GTD45DYR", description: "Описание", date: Date()),
                             PromoCode(service: "Нетфликс", promocode: "76YFYTF34", description: "Описание", date: Date()),
                             PromoCode(service: "БургерКинг", promocode: "YFRGY65GE", description: "Описание", date: Date())]
}

extension MainInteractor: MainInteractorInput {
    
    func getDataCount() -> Int {
        data.count
    }
    
    func getPromoCode(forIndex index: Int) -> PromoCode {
        data[index]
    }
    
}
