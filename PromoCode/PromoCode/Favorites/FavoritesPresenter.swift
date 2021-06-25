//
//  FavoritesPresenter.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

final class FavoritesPresenter {
    
    // MARK: - Properties

	weak var view: FavoritesViewInput?
    weak var moduleOutput: FavoritesModuleOutput?

	private let router: FavoritesRouterInput
	private let interactor: FavoritesInteractorInput

    // MARK: - Init

    init(router: FavoritesRouterInput, interactor: FavoritesInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - Extensions

extension FavoritesPresenter: FavoritesModuleInput {
}

extension FavoritesPresenter: FavoritesViewOutput {
    
    func viewDidLoad() {
        interactor.getAllPromocodes()
        view?.reloadData()
    }
    
    func getPromoCode(forIndex index: Int) -> FavPromoCode {
        interactor.getPromoCode(forIndex: index)
    }
    
    func getDataCount() -> Int {
        interactor.getDataCount()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutput {
}
