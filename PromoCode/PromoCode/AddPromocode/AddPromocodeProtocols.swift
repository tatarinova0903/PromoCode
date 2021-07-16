//
//  AddPromocodeProtocols.swift
//  PromoCode
//
//  Created by Дарья on 14.07.2021.
//

import Foundation

protocol AddGroupModuleInput: AnyObject {
    
}


protocol AddPromocodeViewOutput: AnyObject {
    func addButtonDidTapped(service: String?, promocode: String?, description: String?, date: String?, sphere: Spheres)
}

protocol AddPromocodeViewInput: AnyObject {
    func dismissView()
    
}

protocol AddPromocodeModelInput: AnyObject {
    func addPromocode(promocode: PromoCode, sphere: Spheres, completion: @escaping (Result<PromoCode, СustomError>) -> Void)
}
