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
    
    private let networkManager = NetworkManager.shared
    
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
    
}
