//
//  MainContainer.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit

final class MainContainer {
    let input: MainModuleInput
	let viewController: UIViewController
	private(set) weak var router: MainRouterInput!

//    with context: MainContext
	class func assemble() -> MainContainer {
        let router = MainRouter()
        let interactor = MainInteractor()
        let presenter = MainPresenter(router: router, interactor: interactor)
		let viewController = MainViewController(output: presenter)
        viewController.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass")?.withTintColor(.systemPink, renderingMode: .alwaysOriginal))

		presenter.view = viewController
//		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter

        return MainContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: MainModuleInput, router: MainRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct MainContext {
	weak var moduleOutput: MainModuleOutput?
}
