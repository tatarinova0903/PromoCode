//
//  CustomAddButton.swift
//  PromoCode
//
//  Created by Дарья on 02.07.2021.
//

import UIKit
import PinLayout

class CustomAddButton: UIButton {
    
    // MARK: - Properties
    
    let gradientlayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .radial
        gradient.colors = [
            UIColor.darkPink.cgColor,
            UIColor.lightPink.cgColor,
            UIColor.mediumPink.cgColor
        ]
        return gradient
    }()
    
    private let plusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        return imageView
    }()

    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        configureGradient()
        addSubview(plusImage)
        backgroundColor = .darkGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientlayer.pin
            .all()
        plusImage.pin
            .all()
            .margin(5)
    }
    
    // MARK: - Configures
    
    func configureGradient() {
        layer.addSublayer(gradientlayer)
    }
    
}
