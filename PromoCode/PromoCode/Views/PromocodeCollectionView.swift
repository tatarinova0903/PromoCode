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
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .red
        showsHorizontalScrollIndicator = false
        register(PromoCodeCollectionViewCell.self, forCellWithReuseIdentifier: PromoCodeCollectionViewCell.description().description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
