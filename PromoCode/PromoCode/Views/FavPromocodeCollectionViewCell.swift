//
//  FavPromocodeCollectionViewCell.swift
//  PromoCode
//
//  Created by Дарья on 05.07.2021.
//

import UIKit

protocol FavPromocodeViewCellOutput: AnyObject {
    func addToFavoritesDidTap(promocode: FavPromoCode)
}

final class FavPromocodeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: FavPromocodeViewCellOutput?
    
    private let serviceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let promocodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.darkPink.cgColor
        label.layer.cornerRadius = 5
        return label
    }()
    
    private let addToFavorites: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "heart")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray
        return imageView
    }()
    
    private var promocode = FavPromoCode()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        contentView.backgroundColor = .white
        [promocodeLabel, serviceLabel, addToFavorites].forEach { contentView.addSubview($0) }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addToFavoritesDidTapped))
        addToFavorites.addGestureRecognizer(tapRecognizer)
        configureLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pin.all(5)
        addToFavorites.pin
            .bottom(5)
            .right(5)
            .size(CGSize(width: contentView.frame.height / 2.5, height: contentView.frame.height / 2.5))
        promocodeLabel.pin
            .bottom(10)
            .left(20)
            .right(to: addToFavorites.edge.left)
            .marginRight(5)
            .sizeToFit(.width)
        serviceLabel.pin
            .top(5)
            .bottom(to: promocodeLabel.edge.top)
            .marginBottom(5)
            .left(20)
            .right(5)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        promocode = FavPromoCode()
        serviceLabel.text = nil
        addToFavorites.image = UIImage(systemName: "heart")
        addToFavorites.tintColor = UIColor.gray
    }
    
    // MARK: - Configures
    
    func configureLayer() {
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.white.cgColor
        contentView.layer.shadowRadius = 3
        contentView.layer.shadowOpacity = 0.4
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func configureCell(with promocode: FavPromoCode) {
        self.promocode = promocode
        serviceLabel.text = promocode.service
        promocodeLabel.text = promocode.promocode
        addToFavorites.image = UIImage(systemName: "heart.fill")
        addToFavorites.tintColor = UIColor.darkPink
    }
    
    // MARK: - Handlers
    
    @objc
    func addToFavoritesDidTapped() {
        delegate?.addToFavoritesDidTap(promocode: promocode)
    }
}

