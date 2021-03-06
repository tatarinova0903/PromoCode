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
    func getNumberOfSections() -> Int {
        interactor.getNumberOfSections()
    }
    
    func viewDidLoad() {
        interactor.setupFetchedResultsController(delegate: view)
    }
    
    func getPromoCode(forIndexPath indexPath: IndexPath) -> FavPromoCode {
        interactor.getPromoCode(forIndexPath: indexPath)
    }
    
    func getNumberOfRowsInSection(_ section: Int) -> Int {
        interactor.getNumberOfRowsInSection(section)
    }
    
    func delete(promocode: FavPromoCode) {
        interactor.delete(promocode: promocode)
    }
    
    func searchForQuery(_ query: String) {
        interactor.search(query: query)
    }
    
    func didEndSearching() {
        interactor.didEndSearching()
    }
}

extension FavoritesPresenter: FavoritesInteractorOutput {
    func reloadView() {
        view?.reloadData()
    }
}
