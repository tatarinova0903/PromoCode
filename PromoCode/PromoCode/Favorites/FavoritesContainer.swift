//
//  FavoritesContainer.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit

final class FavoritesContainer {
    let input: FavoritesModuleInput
	let viewController: UIViewController
	private(set) weak var router: FavoritesRouterInput!

	class func assemble() -> FavoritesContainer {
        let router = FavoritesRouter()
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter(router: router, interactor: interactor)
		let viewController = FavoritesViewController(output: presenter)
        viewController.tabBarItem = UITabBarItem(title: "Избранное", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart")?.withTintColor(.darkPink, renderingMode: .alwaysOriginal))

		presenter.view = viewController

		interactor.output = presenter

        return FavoritesContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: FavoritesModuleInput, router: FavoritesRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct FavoritesContext {
	weak var moduleOutput: FavoritesModuleOutput?
}
