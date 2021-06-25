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
    
    private let coreDataManager = CoreDataManager.shared
    
    private var data = [FavPromoCode]()
    
//    let data: [PromoCode] = [PromoCode(service: "Кинопоиск", promocode: "34RFD67T", description: "Описание", date: Date()),
//                             PromoCode(service: "Амедиатека", promocode: "GTD45DYR", description: "Описание", date: Date()),
//                             PromoCode(service: "Нетфликс", promocode: "76YFYTF34", description: "Описание", date: Date()),
//                             PromoCode(service: "БургерКинг", promocode: "YFRGY65GE", description: "Описание", date: Date())]
}

extension FavoritesInteractor: FavoritesInteractorInput {
    
    func getAllPromocodes() {
        data = coreDataManager.getPromoCodes()
    }
    
    func getDataCount() -> Int {
        data.count
    }
    
    func getPromoCode(forIndex index: Int) -> FavPromoCode {
        data[index]
    }
}
