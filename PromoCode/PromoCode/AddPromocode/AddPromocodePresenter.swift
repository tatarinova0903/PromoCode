//
//  AddPromocodePresenter.swift
//  PromoCode
//
//  Created by Дарья on 14.07.2021.
//

import Foundation


final class AddPromocodePresenter {
    
    // MARK: - Properties
    
    weak var view: AddPromocodeViewInput?
    private let model: AddPromocodeModelInput
    
    weak var moduleOutput: MainModuleInput?
    
    // MARK: - Init
    
    init(model: AddPromocodeModelInput) {
        self.model = model
    }
}

// MARK: - Extensions

extension AddPromocodePresenter: AddPromocodeViewOutput {
    func addButtonDidTapped(service: String?, promocode: String?, description: String?, date: String?, sphere: Spheres) {
        guard let service = service,
              let promocode = promocode,
              let dateStr = date else {
            return
        }
        let newPromocode = PromoCode(service: service, promocode: promocode, description: description ?? "", date: dateStr.toDate() ?? Date())
        model.addPromocode(promocode: newPromocode, sphere: sphere) { [weak self] res in
            switch res {
            case .success(let promocode):
                let currentShownSphere = self?.moduleOutput?.getCurrentShownSphere()
                if currentShownSphere == sphere || currentShownSphere == .all {
                    self?.moduleOutput?.promocodeDidAdd(promocode: promocode)
                }
                self?.view?.dismissView()
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AddPromocodePresenter: AddGroupModuleInput {
    
}
