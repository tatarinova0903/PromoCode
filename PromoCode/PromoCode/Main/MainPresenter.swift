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
    
    private var sphere: Spheres = .films

    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    func getPromocodes(for sphere: Spheres) {
        interactor.getPromocodes(for: sphere)
    }
}

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
        interactor.addToFavorites(promocode: promocode)
    }
}

extension MainPresenter: MainInteractorOutput {
    func promocodesDidLoad() {
        view?.stopActivityIndicator()
        view?.reloadData()
    }
}
