//
//  PromoCodeTableViewCell.swift
//  PromoCode
//
//  Created by Дарья on 25.06.2021.
//

import UIKit

final class PromoCodeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    weak var delegate: MainViewInput?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
    private var isLiked: Bool = false
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(label)
        contentView.addSubview(addToFavorites)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addToFavoritesDidTapped))
        addToFavorites.addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.pin
            .left(20)
            .sizeToFit()
        addToFavorites.pin
            .right(10)
            .vertically()
            .width(contentView.frame.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        promocode = PromoCode()
        label.text = nil
        addToFavorites.image = UIImage(systemName: "heart")
        addToFavorites.tintColor = UIColor.gray
    }
    
    // MARK: - Configures
    
    func configureCell(with promocode: PromoCode) {
        self.promocode = promocode
        label.text = promocode.service
        addToFavorites.image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        addToFavorites.tintColor = isLiked ? UIColor.systemPink : UIColor.gray
    }
    
    // MARK: - Handlers
    
    @objc
    func addToFavoritesDidTapped() {
        delegate?.addToFavoritesDidTapped(promocode: promocode)
        isLiked.toggle()
        addToFavorites.image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        addToFavorites.tintColor = isLiked ? UIColor.systemPink : UIColor.gray
    }
    
}
