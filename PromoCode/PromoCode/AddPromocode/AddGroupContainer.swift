//
//  AddGroupContainer.swift
//  PromoCode
//
//  Created by Дарья on 14.07.2021.
//

import UIKit

final class AddPromocodeContainer {
    let input: AddGroupModuleInput
    let viewController: UIViewController

    class func assemble() -> AddPromocodeContainer {
        let presenter = AddPromocodePresenter()
        let viewController = AddPromocodeViewController(output: presenter)

        presenter.view = viewController

//        model.output = presenter

        return AddPromocodeContainer(view: viewController, input: presenter)
    }

    private init(view: UIViewController, input: AddGroupModuleInput) {
        self.viewController = view
        self.input = input
    }
}
