//
//  MainInteractor.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

final class MainInteractor {
    
    // MARK: - Properties
    
	weak var output: MainInteractorOutput?
    
    private let networkManager: NetworkManagerDescription = NetworkManager.shared
    private let coreDataManager: CoreDataManagerDescription = CoreDataManager.shared
    
    private var data = [PromoCode]()
}

// MARK: - Extensions

extension MainInteractor: MainInteractorInput {
    
    func getPromocodes(for sphere: Spheres) {
        data.removeAll()
        output?.cleanView()
        networkManager.getPromocodes(for: sphere) { [weak self] (res) in
            guard let self = self else { return }
            switch res {
            case .success(let promocodes):
                self.data = promocodes
                self.output?.promocodesDidLoad()
            case .failure(let err):
                print(err.rawValue)
            }
        }
    }
    
    func getPromocodesCount() -> Int {
        data.count
    }
    
    func getPromoCode(forIndex index: Int) -> PromoCode {
        data[index]
    }
    
    func addToFavorites(promocode: PromoCode) {
        let index = getIndex(for: promocode)
        guard let safeIndex = index else {
            return
        }
        data[safeIndex].isInFavorites = promocode.isInFavorites
        coreDataManager.addPromoCode(promocode: promocode)
    }
    
    func deleteFromFavorites(promocode: PromoCode) {
        let index = getIndex(for: promocode)
        guard let safeIndex = index else {
            return
        }
        data[safeIndex].isInFavorites = promocode.isInFavorites
        coreDataManager.deletePromoCode(promocode: promocode)
    }
    
    func getIndex(for promocode: PromoCode) -> Int? {
        return data.firstIndex { $0.id == promocode.id }
    }
    
}
