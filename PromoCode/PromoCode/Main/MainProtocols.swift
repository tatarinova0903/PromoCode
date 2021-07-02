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
    func startActivityIndicator()
    func stopActivityIndicator()
    func setSphere(with sphere: Spheres)
}

protocol MainViewOutput: class {
    var currentSphere: Spheres { get set }
    
    func viewDidLoad()
    
    func getPromoCode(forIndex index: Int) -> PromoCode
    func getDataCount() -> Int
    
    func addToFavoritesDidTapped(promocode: PromoCode)
    func doneSphereTapped(sphere: Spheres)
}

protocol MainInteractorInput: class {
    func getPromocodes(for sphere: Spheres)
    func getDataCount() -> Int
    func getPromoCode(forIndex index: Int) -> PromoCode
    
    func addToFavorites(promocode: PromoCode)
}

protocol MainInteractorOutput: class {
    func promocodesDidLoad()
    func cleanView()
}

protocol MainRouterInput: class {
}
