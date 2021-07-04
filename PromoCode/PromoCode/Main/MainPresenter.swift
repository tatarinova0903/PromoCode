//
//  MainPresenter.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

final class MainPresenter {
    
    // MARK: - Properties
    
	weak var view: MainViewInput?
    weak var moduleOutput: MainModuleOutput?

	private let router: MainRouterInput
	private let interactor: MainInteractorInput
    
    private var sphere: Spheres = .films

    // MARK: - Init
    
    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Handlers
    
    func getPromocodes(for sphere: Spheres) {
        interactor.getPromocodes(for: sphere)
    }
}

// MARK: - Extensions

extension MainPresenter: MainModuleInput {
}

extension MainPresenter: MainViewOutput {
    var currentSphere: Spheres {
        get {
           sphere
        }
        set {
            sphere = newValue
            view?.startActivityIndicator()
            getPromocodes(for: newValue)
        }
    }
    func viewDidLoad() {
        view?.startActivityIndicator()
        interactor.getPromocodes(for: sphere)
    }
    
    func getPromoCode(forIndex index: Int) -> PromoCode {
        interactor.getPromoCode(forIndex: index)
    }
    
    func getDataCount() -> Int {
        interactor.getDataCount()
    }
    
    func addToFavoritesDidTapped(promocode: PromoCode) {
        let index = interactor.getIndex(for: promocode)
        guard let safeIndex = index else {
            return
        }
        view?.changeCollectionCell(atIndex: safeIndex, with: promocode)
        interactor.addToFavorites(promocode: promocode)
    }
    
    func doneSphereTapped(sphere: Spheres) {
        currentSphere = sphere
        view?.setSphere(with: sphere)
    }
}

extension MainPresenter: MainInteractorOutput {
    func promocodesDidLoad() {
        view?.stopActivityIndicator()
        view?.reloadData()
    }
    
    func cleanView() {
        view?.reloadData()
    }
}
