//
//  PromoCodeTableViewCell.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//

import UIKit

final class PromoCodeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    weak var delegate: MainViewInput?
    
    private let serviceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let promocodeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.darkGray.cgColor
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
    
    private var promocode = PromoCode()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        contentView.backgroundColor = .white
        [promocodeLabel, serviceLabel, addToFavorites].forEach { contentView.addSubview($0) }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addToFavoritesDidTapped))
        addToFavorites.addGestureRecognizer(tapRecognizer)
        contentView.layer.cornerRadius = 20
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        serviceLabel.pin
            .top(5)
            .left(20)
            .right(5)
            .sizeToFit(.width)
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
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        promocode = PromoCode()
        serviceLabel.text = nil
        addToFavorites.image = UIImage(systemName: "heart")
        addToFavorites.tintColor = UIColor.gray
    }
    
    // MARK: - Configures
    
    func configureCell(with promocode: PromoCode) {
        self.promocode = promocode
        serviceLabel.text = promocode.service
        promocodeLabel.text = promocode.promocode
        addToFavorites.image = promocode.isInFavorites ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        addToFavorites.tintColor = promocode.isInFavorites ? UIColor.darkPink : UIColor.gray
    }
    
    // MARK: - Handlers
    
    @objc
    func addToFavoritesDidTapped() {
        promocode.isInFavorites.toggle()
        delegate?.addToFavoritesDidTapped(promocode: promocode)
        addToFavorites.image = promocode.isInFavorites ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        addToFavorites.tintColor = promocode.isInFavorites ? UIColor.darkPink : UIColor.gray
    }
    
}
