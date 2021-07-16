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
        let model = AddPromocodeModel()
        let presenter = AddPromocodePresenter(model: model)
        let viewController = AddPromocodeViewController(output: presenter)

        presenter.view = viewController

        return AddPromocodeContainer(view: viewController, input: presenter)
    }

    private init(view: UIViewController, input: AddGroupModuleInput) {
        self.viewController = view
        self.input = input
    }
}
