//
//  CoreDataManager.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//

import UIKit
import CoreData

protocol CoreDataManagerDescription {
    func getPromoCodes() -> [FavPromoCode]
}

final class CoreDataManager: CoreDataManagerDescription {
    static let shared = CoreDataManager()
    
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    private init() { }
    
    func getPromoCodes() -> [FavPromoCode] {
        let promocodes = try? context?.fetch(FavPromoCode.fetchRequest()) as? [FavPromoCode]
        return promocodes ?? []
    }
    
    func addPromoCode() {
        guard let context = context else { return }
        let newPromoCode = FavPromoCode(context: context)
        newPromoCode.id = "ID"
        newPromoCode.service = "Еда"
        newPromoCode.promocode = "6GG"
        newPromoCode.date = Date()
        newPromoCode.describe = ""
        
        do {
            try context.save()
        } catch let err {
            print(err.localizedDescription)
        }
    }
}
