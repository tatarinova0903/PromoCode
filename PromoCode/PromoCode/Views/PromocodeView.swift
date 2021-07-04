//
//  PromocodeView.swift
//  PromoCode
//
//  Created by Дарья on 03.07.2021.
//

import UIKit

class PromocodeView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: MainViewInput?

    private let serviceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let descroptionTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .white
        textView.textColor = .black
        return textView
    }()
    
    private let dateLabel: UILabel = {
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
    
    private let margin: CGFloat = 10
    
    private var promocode = PromoCode()

    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        [serviceLabel, descroptionTextView, dateLabel, promocodeLabel, addToFavorites].forEach { addSubview($0) }
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(addToFavoritesDidTapped))
        addToFavorites.addGestureRecognizer(tapRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        serviceLabel.pin
            .top(margin)
            .horizontally(margin)
            .height(self.frame.height / 5)
        descroptionTextView.pin
            .top(to: serviceLabel.edge.bottom)
            .horizontally(margin)
            .height(self.frame.height / 3)
        addToFavorites.pin
            .bottomRight(margin / 2)
            .size(CGSize(width: self.frame.height / 4, height: self.frame.height / 4))
        promocodeLabel.pin
            .before(of: addToFavorites, aligned: .bottom)
            .left(margin)
            .marginBottom(margin / 2)
            .right(to: addToFavorites.edge.left)
            .marginRight(margin)
            .height(self.frame.height / 8)
        dateLabel.pin
            .above(of: promocodeLabel, aligned: .center)
            .marginBottom(margin / 2)
            .width(of: promocodeLabel)
            .height(self.frame.height / 8)
    }
    
    // MARK: - Configures
    
    func configure(with promocode: PromoCode) {
        self.promocode = promocode
        serviceLabel.text = promocode.service
        descroptionTextView.text = promocode.description
        dateLabel.text = "Действует до \(promocode.date.toString())"
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
