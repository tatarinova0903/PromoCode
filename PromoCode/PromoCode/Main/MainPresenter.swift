//
//  MainPresenter.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit

final class MainPresenter {
    
    // MARK: - Properties
    
	weak var view: MainViewInput?
    weak var moduleOutput: MainModuleOutput?

	private let router: MainRouterInput
	private let interactor: MainInteractorInput
    
    private var sphere: Spheres = .all

    // MARK: - Init
    
    init(router: MainRouterInput, interactor: MainInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
    
    // MARK: - Handlers
    
    func getPromocodes(for sphere: Spheres) {
        view?.startActivityIndicator()
        if sphere == .all {
            interactor.getAllPromocodes()
        } else {
            interactor.getPromocodes(for: sphere)
        }
    }
    
    func getIndex(for sphere: Spheres) -> Int? {
        Spheres.allCases.firstIndex(of: sphere)
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
            guard let oldIndex = getIndex(for: sphere), let newIndex = getIndex(for: newValue) else { return }
            getPromocodes(for: newValue)
            view?.changeSphereCollectionCell(atOldIndex: oldIndex, atNewIndex: newIndex)
            sphere = newValue
        }
    }
    
    func viewDidLoad() {
        currentSphere = .all
    }
    
    func viewDidAppear() {
        let currentSphereIndex = getIndex(for: currentSphere) ?? 0
        if currentSphereIndex == 0 {
            view?.changeSphereCollectionCell(atOldIndex: nil, atNewIndex: 0)
        }
    }
    
    func getPromoCode(forIndex index: Int) -> PromoCode {
        interactor.getPromoCode(forIndex: index)
    }
    
    func getPromocodesCount() -> Int {
        interactor.getPromocodesCount()
    }
    
    func getSpheresCount() -> Int {
        Spheres.allCases.count
    }
    
    func getSphere(forIndex index: Int) -> Spheres {
        Spheres.allCases[index]
    }
    
    func getSphereCellLength(forIndex index: Int) -> CGFloat {
        let sphere = Spheres.allCases[index]
        return CGFloat(sphere.inRussian().count * 20)
    }
    
    func addToFavoritesDidTapped(promocode: PromoCode) {
        let index = interactor.getIndex(for: promocode)
        guard let safeIndex = index else {
            return
        }
        view?.changePromocodeCollectionCell(atIndex: safeIndex, with: promocode)
        if promocode.isInFavorites {
            interactor.addToFavorites(promocode: promocode)
        } else {
            interactor.deleteFromFavorites(promocode: promocode)
        }
    }
    
    func addPromocodeButtonDidTapped() {
        router.showAddPromocodeController()
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
