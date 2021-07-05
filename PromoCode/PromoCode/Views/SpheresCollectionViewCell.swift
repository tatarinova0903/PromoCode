//
//  SpheresCollectionViewCell.swift
//  PromoCode
//
//  Created by Дарья on 04.07.2021.
//

import UIKit

class SpheresCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: MainViewInput?
    
    private let sphereLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        contentView.backgroundColor = .mediumGray
        contentView.addSubview(sphereLabel)
        contentView.layer.cornerRadius = frame.height * 0.4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin.all(5)
        sphereLabel.pin.all(5)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        sphereLabel.textColor = .white
    }
    
    // MARK: - Configures
    
    func configureCell(with sphere: Spheres, isChosen: Bool) {
        contentView.backgroundColor = isChosen ? UIColor.darkPink : UIColor.mediumGray
        sphereLabel.text = sphere.inRussian()
    }
    
    func configureCell(isChosen: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn]) { [weak self] in
            self?.contentView.backgroundColor = isChosen ? UIColor.darkPink : UIColor.mediumGray
        }
    }

}
