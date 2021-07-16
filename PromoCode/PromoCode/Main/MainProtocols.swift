//
//  MainProtocols.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit

protocol MainModuleInput: AnyObject {
    
    func getCurrentShownSphere() -> Spheres
    
    func promocodeDidAdd(promocode: PromoCode)
}

protocol MainModuleOutput: AnyObject {
}

protocol MainViewInput: AnyObject {
    func reloadData()
    func reloadData(at index: Int)
    
    func changePromocodeCollectionCell(atIndex index: Int, with promocode: PromoCode)
    func changeSphereCollectionCell(atOldIndex oldIndex: Int?, atNewIndex newIndex: Int)
    
    func startActivityIndicator()
    func stopActivityIndicator()
}

protocol SpheresCollectionOutput: AnyObject {
    func setSphere(with sphere: Spheres)
}

protocol MainViewOutput: AnyObject {
    var currentSphere: Spheres { get set }
    
    func viewDidLoad()
    func viewDidAppear()
    
    func getPromoCode(forIndex index: Int) -> PromoCode
    func getPromocodesCount() -> Int
    func addToFavoritesDidTapped(promocode: PromoCode)
    
    func getSpheresCount() -> Int
    func getSphere(forIndex index: Int) -> Spheres
    func getSphereCellLength(forIndex index: Int) -> CGFloat
    
    func addPromocodeButtonDidTapped()
    
}

protocol MainInteractorInput: AnyObject {
    func addPromocode(promocode: PromoCode) -> Int
    func getAllPromocodes()
    func getPromocodes(for sphere: Spheres)
    func getPromocodesCount() -> Int
    func getPromoCode(forIndex index: Int) -> PromoCode
    func getIndex(for promocode: PromoCode) -> Int?
    func addToFavorites(promocode: PromoCode)
    func deleteFromFavorites(promocode: PromoCode)
}

protocol MainInteractorOutput: AnyObject {
    func promocodesDidLoad()
    func cleanView()
}

protocol MainRouterInput: AnyObject {
    func showAddPromocodeController(moduleOutput: MainModuleInput)
}
