//
//  FavoritesInteractor.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit
import CoreData

final class FavoritesInteractor {
    weak var output: FavoritesInteractorOutput?
    
    private let coreDataManager: CoreDataManagerDescription = CoreDataManager.shared
    
    private var data = [FavPromoCode]()
        
    private let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

}

extension FavoritesInteractor: FavoritesInteractorInput {
    
    func getNumberOfRowsInSection(_ section: Int) -> Int {
        coreDataManager.getNumberOfRowsInSection(section)
    }
    
    func getNumberOfSections() -> Int {
        coreDataManager.getNumberOfSections()
    }
    
    func getAllPromocodes(delegate: FavoritesViewInput?) {
        data = coreDataManager.getPromoCodes(delegate: delegate)
    }
    
    func getPromoCode(forIndexPath indexPath: IndexPath) -> FavPromoCode {
        coreDataManager.getPromocode(byIndexPath: indexPath)
    }
    
    func delete(promocode: FavPromoCode) {
        coreDataManager.delete(promocode: promocode)
    }
}
