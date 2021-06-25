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
    func getPromoCode(forIndex index: Int) -> PromoCode
    func getDataCount() -> Int
}

protocol MainInteractorInput: class {
    func getDataCount() -> Int
    func getPromoCode(forIndex index: Int) -> PromoCode
}

protocol MainInteractorOutput: class {
}

protocol MainRouterInput: class {
}
