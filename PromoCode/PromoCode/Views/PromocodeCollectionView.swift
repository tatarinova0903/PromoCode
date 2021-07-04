//
//  CustomSpheresCollectionView.swift
//  PromoCode
//
//  Created by Дарья on 02.07.2021.
//

import UIKit

class PromocodeCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .darkGray
        showsHorizontalScrollIndicator = false
        register(PromocodeCollectionViewCell.self, forCellWithReuseIdentifier: PromocodeCollectionViewCell.description().description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
