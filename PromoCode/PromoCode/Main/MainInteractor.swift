//
//  MainInteractor.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

final class MainInteractor {
	weak var output: MainInteractorOutput?
    
    private let networkManager: NetworkManagerDescription = NetworkManager.shared
    private let coreDataManager: CoreDataManagerDescription = CoreDataManager.shared
    
    private var data = [PromoCode]()
}

extension MainInteractor: MainInteractorInput {
    
    func viewDidLoad() {
        networkManager.getPromocodes(for: .films) { [weak self] (res) in
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
    
    func getDataCount() -> Int {
        data.count
    }
    
    func getPromoCode(forIndex index: Int) -> PromoCode {
        data[index]
    }
    
    func addToFavorites(promocode: PromoCode) {
        if promocode.isInFavorites {
            coreDataManager.addPromoCode(promocode: promocode)
        } else {
            coreDataManager.deletePromoCode(promocode: promocode)
        }
    }
    
}
