//
//  CustomTabBarPresenter.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

final class CustomTabBarPresenter {
	weak var tabbar: CustomTabBarViewInput?
    weak var moduleOutput: CustomTabBarModuleOutput?

	private let router: CustomTabBarRouterInput
	private let interactor: CustomTabBarInteractorInput

    init(router: CustomTabBarRouterInput, interactor: CustomTabBarInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension CustomTabBarPresenter: CustomTabBarModuleInput {
}

extension CustomTabBarPresenter: CustomTabBarViewOutput {
}

extension CustomTabBarPresenter: CustomTabBarInteractorOutput {
}
