//
//  SpheresCollectionView.swift
//  PromoCode
//
//  Created by Дарья on 04.07.2021.
//

import UIKit

class SpheresCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .darkGray
        showsHorizontalScrollIndicator = false
        register(SpheresCollectionViewCell.self, forCellWithReuseIdentifier: SpheresCollectionViewCell.description().description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
