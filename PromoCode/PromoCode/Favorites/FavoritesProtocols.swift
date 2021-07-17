//
//  FavoritesProtocols.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation
import CoreData

protocol FavoritesModuleInput {
	var moduleOutput: FavoritesModuleOutput? { get }
}

protocol FavoritesModuleOutput: class {
}

protocol FavoritesViewInput: class, NSFetchedResultsControllerDelegate {
    func reloadData()
}

protocol FavoritesViewOutput: class {
    func viewDidLoad()
    
    func getNumberOfRowsInSection(_ section: Int) -> Int
    func getNumberOfSections() -> Int
    func getPromoCode(forIndexPath indexPath: IndexPath) -> FavPromoCode
    
    func delete(promocode: FavPromoCode)
    
    func searchForQuery(_ query: String)
}

protocol FavoritesInteractorInput: class {
    func getAllPromocodes(delegate: FavoritesViewInput?)
    func getNumberOfRowsInSection(_ section: Int) -> Int
    func getNumberOfSections() -> Int
    func getPromoCode(forIndexPath indexPath: IndexPath) -> FavPromoCode
    func delete(promocode: FavPromoCode)
    func search(query: String)
}

protocol FavoritesInteractorOutput: class {
    func reloadView()
}

protocol FavoritesRouterInput: class {
}
