//
//  CustomSpheresCollectionView.swift
//  PromoCode
//
//  Created by Дарья on 02.07.2021.
//

import UIKit

class CustomSpheresCollectionView: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 2
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = .red
        showsHorizontalScrollIndicator = false
        register(PromocodeSphereCollectionViewCell.self, forCellWithReuseIdentifier: PromocodeSphereCollectionViewCell.description().description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
