//
//  MainPresenter.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

final class MainPresenter {
	weak var view: MainViewInput?
    weak var moduleOutput: MainModuleOutput?

	private let router: MainRouterInput
	private let interactor: MainInteractorInput

    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension MainPresenter: MainModuleInput {
}

extension MainPresenter: MainViewOutput {
    func getPromoCode(forIndex index: Int) -> PromoCode {
        interactor.getPromoCode(forIndex: index)
    }
    
    func getDataCount() -> Int {
        interactor.getDataCount()
    }
}

extension MainPresenter: MainInteractorOutput {
}
