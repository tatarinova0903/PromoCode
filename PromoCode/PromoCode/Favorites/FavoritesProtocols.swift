//
//  FavoritesProtocols.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

protocol FavoritesModuleInput {
	var moduleOutput: FavoritesModuleOutput? { get }
}

protocol FavoritesModuleOutput: class {
}

protocol FavoritesViewInput: class {
    func reloadData()
}

protocol FavoritesViewOutput: class {
    func viewDidLoad()
    func getDataCount() -> Int
    func getPromoCode(forIndex index: Int) -> FavPromoCode
}

protocol FavoritesInteractorInput: class {
    func getAllPromocodes() 
    func getDataCount() -> Int
    func getPromoCode(forIndex index: Int) -> FavPromoCode
}

protocol FavoritesInteractorOutput: class {
}

protocol FavoritesRouterInput: class {
}
