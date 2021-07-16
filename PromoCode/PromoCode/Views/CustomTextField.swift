//
//  CustomTextField.swift
//  PromoCode
//
//  Created by Дарья on 14.07.2021.
//

import UIKit

final class CustomTextField: UITextField {
    
    // MARK: - Properties
    
    let insets: UIEdgeInsets
    
    // MARK: - Init
    
    init(insets: UIEdgeInsets) {
        self.insets = insets
        super.init(frame: .zero)
        attributedPlaceholder = NSAttributedString(string: "placeholder text", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        textColor = .darkGray
        layer.cornerRadius = 15
        layer.borderWidth = 2
        layer.borderColor = UIColor.mediumGray.cgColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
}
