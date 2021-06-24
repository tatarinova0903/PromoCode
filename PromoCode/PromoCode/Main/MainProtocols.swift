//
//  MainProtocols.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

protocol MainModuleInput {
	var moduleOutput: MainModuleOutput? { get }
}

protocol MainModuleOutput: class {
}

protocol MainViewInput: class {
}

protocol MainViewOutput: class {
}

protocol MainInteractorInput: class {
}

protocol MainInteractorOutput: class {
}

protocol MainRouterInput: class {
}
