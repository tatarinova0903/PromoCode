//
//  AddPromocodeModelInput.swift
//  PromoCode
//
//  Created by Дарья on 16.07.2021.
//

import Foundation

final class AddPromocodeModel {
    private let networkManager: NetworkManagerDescription = NetworkManager.shared
}

extension AddPromocodeModel: AddPromocodeModelInput {
    func addPromocode(promocode: PromoCode, sphere: Spheres) {
        networkManager.addPromocode(promocode: promocode, sphere: sphere)
    }
}
