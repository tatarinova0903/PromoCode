//
//  PromocodeSphereScrollView.swift
//  PromoCode
//
//  Created by Дарья on 01.07.2021.
//

import UIKit
import PinLayout

class PromocodeSphereCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private let label: CustomLabel = {
        let label = CustomLabel()
        label.backgroundColor = UIColor.lightGray
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.white.cgColor
        label.layer.cornerRadius = 5
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        label.pin
            .all()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    // MARK: - Configures
    
    func configure(with text: String) {
        label.text = text
    }
    
    // MARK: - Handlers

}
