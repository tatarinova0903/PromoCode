//
//  CustomPicker.swift
//  PromoCode
//
//  Created by Дарья on 02.07.2021.
//

import UIKit

final class CustomSphereTextField: UITextField {
    
    // MARK: - Properties
    
    let insets: UIEdgeInsets
    
    // MARK: - Init
    
    init(insets: UIEdgeInsets, cornerRadius: CGFloat = 0) {
        self.insets = insets
        super.init(frame: .zero)
        layer.cornerRadius = cornerRadius
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override functions
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    
    // MARK: - Handlers
    
    func setInputViewSpherePicker(with spherePicker: UIPickerView, target: Any, selector: Selector) {
        self.inputView = spherePicker
        let screenWidth = UIScreen.main.bounds.width
        configureToolBar(screenWidth: screenWidth, selector: selector)

    }
    
    private func configureToolBar(screenWidth: CGFloat, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        self.inputAccessoryView = toolBar
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }

}
