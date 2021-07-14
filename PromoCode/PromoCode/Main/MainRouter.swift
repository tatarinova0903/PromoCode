//
//  MainRouter.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit

final class MainRouter {
    weak var sourceViewController: UIViewController?
}

extension MainRouter: MainRouterInput {
    
    func showAddPromocodeController() {
        let addPromocodeContainer = AddPromocodeContainer.assemble()
        sourceViewController?.present(addPromocodeContainer.viewController, animated: true, completion: nil)
    }
}
