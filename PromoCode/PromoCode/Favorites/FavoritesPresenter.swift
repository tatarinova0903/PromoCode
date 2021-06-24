//
//  FavoritesPresenter.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

final class FavoritesPresenter {
	weak var view: FavoritesViewInput?
    weak var moduleOutput: FavoritesModuleOutput?

	private let router: FavoritesRouterInput
	private let interactor: FavoritesInteractorInput

    init(router: FavoritesRouterInput, interactor: FavoritesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension FavoritesPresenter: FavoritesModuleInput {
}

extension FavoritesPresenter: FavoritesViewOutput {
    func getPromoCode(forIndex index: Int) -> PromoCode {
        interactor.getPromoCode(forIndex: index)
    }
    
    func getDataCount() -> Int {
        interactor.getDataCount()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutput {
}
