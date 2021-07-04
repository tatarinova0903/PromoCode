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

protocol MainModuleOutput: AnyObject {
}

protocol MainViewInput: AnyObject {
    func reloadData()
    func addToFavoritesDidTapped(promocode: PromoCode)
    func changeCollectionCell(atIndex index: Int, with promocode: PromoCode)
    func startActivityIndicator()
    func stopActivityIndicator()
    func setSphere(with sphere: Spheres)
}

protocol MainViewOutput: AnyObject {
    var currentSphere: Spheres { get set }
    
    func viewDidLoad()
    
    func getPromoCode(forIndex index: Int) -> PromoCode
    func getDataCount() -> Int
    
    func addToFavoritesDidTapped(promocode: PromoCode)
    func doneSphereTapped(sphere: Spheres)
}

protocol MainInteractorInput: AnyObject {
    func getPromocodes(for sphere: Spheres)
    func getDataCount() -> Int
    func getPromoCode(forIndex index: Int) -> PromoCode
    func getIndex(for promocode: PromoCode) -> Int?
    func addToFavorites(promocode: PromoCode)
}

protocol MainInteractorOutput: AnyObject {
    func promocodesDidLoad()
    func cleanView()
}

protocol MainRouterInput: AnyObject {
}
