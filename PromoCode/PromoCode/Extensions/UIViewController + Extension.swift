//
//  UIViewController + Extension.swift
//  PromoCode
//
//  Created by Дарья on 03.07.2021.
//

import UIKit

extension UIViewController {
    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
