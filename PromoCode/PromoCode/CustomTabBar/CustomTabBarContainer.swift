//
//  CustomTabBarContainer.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit

final class CustomTabBarContainer {
    let input: CustomTabBarModuleInput
	let tabBarController: UITabBarController
	private(set) weak var router: CustomTabBarRouterInput!

	class func assemble() -> CustomTabBarContainer {
        let router = CustomTabBarRouter()
        let interactor = CustomTabBarInteractor()
        let presenter = CustomTabBarPresenter(router: router, interactor: interactor)
		let tabBarController = CustomTabBarViewController(output: presenter)

		presenter.tabbar = tabBarController

		interactor.output = presenter

        return CustomTabBarContainer(tabbar: tabBarController, input: presenter, router: router)
	}

    private init(tabbar: UITabBarController, input: CustomTabBarModuleInput, router: CustomTabBarRouterInput) {
		self.tabBarController = tabbar
        self.input = input
		self.router = router
	}
}

struct CustomTabBarContext {
	weak var moduleOutput: CustomTabBarModuleOutput?
}
