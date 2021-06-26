//
//  MainProtocols.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

protocol MainModuleInput {
	var moduleOutput: MainModuleOutput? { get }
}

protocol MainModuleOutput: class {
}

protocol MainViewInput: class {
    func reloadData()
    func addToFavoritesDidTapped(promocode: PromoCode)
}

protocol MainViewOutput: class {
    func viewDidLoad()
    
    func getPromoCode(forIndex index: Int) -> PromoCode
    func getDataCount() -> Int
    
    func addToFavoritesDidTapped(promocode: PromoCode)
}

protocol MainInteractorInput: class {
    func viewDidLoad()
    
    func getDataCount() -> Int
    func getPromoCode(forIndex index: Int) -> PromoCode
    
    func addToFavorites(promocode: PromoCode)
}

protocol MainInteractorOutput: class {
    func promocodesDidLoad()
}

protocol MainRouterInput: class {
}
