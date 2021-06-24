//
//  CustomTabBarProtocols.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

protocol CustomTabBarModuleInput {
	var moduleOutput: CustomTabBarModuleOutput? { get }
}

protocol CustomTabBarModuleOutput: class {
}

protocol CustomTabBarViewInput: class {
}

protocol CustomTabBarViewOutput: class {
}

protocol CustomTabBarInteractorInput: class {
}

protocol CustomTabBarInteractorOutput: class {
}

protocol CustomTabBarRouterInput: class {
}
