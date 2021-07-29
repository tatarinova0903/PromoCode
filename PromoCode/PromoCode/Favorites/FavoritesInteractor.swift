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
    
    private var isSearchingForQuery = false

}

extension FavoritesInteractor: FavoritesInteractorInput {
    
    func getNumberOfRowsInSection(_ section: Int) -> Int {
        if isSearchingForQuery {
            return data.count
        }
        return coreDataManager.getNumberOfRowsInSection(section)
    }
    
    func getNumberOfSections() -> Int {
        coreDataManager.getNumberOfSections()
    }
    
    func setupFetchedResultsController(delegate: FavoritesViewInput?) {
        coreDataManager.setupFetchedResultsController(delegate: delegate)
    }
    
    func getPromoCode(forIndexPath indexPath: IndexPath) -> FavPromoCode {
        if isSearchingForQuery {
            return data[indexPath.row]
        }
        return coreDataManager.getPromocode(byIndexPath: indexPath)
    }
    
    func delete(promocode: FavPromoCode) {
        coreDataManager.delete(promocode: promocode)
    }
    
    func search(query: String) {
        isSearchingForQuery = true
        data = coreDataManager.search(query: query)
        output?.reloadView()
    }
    
    func didEndSearching() {
        isSearchingForQuery = false
        output?.reloadView()
    }
}
