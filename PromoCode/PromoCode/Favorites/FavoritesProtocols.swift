//
//  FavoritesProtocols.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import Foundation

protocol FavoritesModuleInput {
	var moduleOutput: FavoritesModuleOutput? { get }
}

protocol FavoritesModuleOutput: class {
}

protocol FavoritesViewInput: class {
}

protocol FavoritesViewOutput: class {
}

protocol FavoritesInteractorInput: class {
}

protocol FavoritesInteractorOutput: class {
}

protocol FavoritesRouterInput: class {
}
