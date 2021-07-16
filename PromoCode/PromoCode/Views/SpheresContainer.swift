//
//  SpheresContainer.swift
//  PromoCode
//
//  Created by Дарья on 15.07.2021.
//

import UIKit

final class SpheresContainer: UIView {

    // MARK: - Properties
    
    private let filmsLabel: UILabel = {
        let label = UILabel()
        label.tag = Spheres.allCases.firstIndex(of: .films) ?? 0
        label.text = Spheres.films.inRussian()
        label.layer.cornerRadius = 20
        return label
    }()
    
    private let foodLabel: UILabel = {
        let label = UILabel()
        label.tag = Spheres.allCases.firstIndex(of: .food) ?? 0
        label.text = Spheres.food.inRussian()
        return label
    }()
    
    private let clothesLabel: UILabel = {
        let label = UILabel()
        label.tag = Spheres.allCases.firstIndex(of: .clothes) ?? 0
        label.text = Spheres.clothes.inRussian()
        return label
    }()
    
    private let travellingLabel: UILabel = {
        let label = UILabel()
        label.tag = Spheres.allCases.firstIndex(of: .travelling) ?? 0
        label.text = Spheres.travelling.inRussian()
        return label
    }()
    
    private let gamesLabel: UILabel = {
        let label = UILabel()
        label.tag = Spheres.allCases.firstIndex(of: .games) ?? 0
        label.text = Spheres.games.inRussian()
        return label
    }()
    
    private let othersLabel: UILabel = {
        let label = UILabel()
        label.tag = Spheres.allCases.firstIndex(of: .others) ?? 0
        label.text = Spheres.others.inRussian()
        return label
    }()
    
    var selectedSphereTag: Int = 1

    // MARK: - Override functions
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        [filmsLabel, foodLabel, clothesLabel, travellingLabel, gamesLabel, othersLabel].forEach({ addSubview($0) })
        
        configureLayouts()
        configureLabels()

    }
    
    // MARK: - Configures
    
    func configureLayouts() {
        
        let height = round((frame.height - 15) / 2)
        
        filmsLabel.pin
            .topLeft(5)
            .width((frame.width - 10) / 4)
            .height(height)
            .margin(5)

        foodLabel.pin
            .after(of: filmsLabel, aligned: .center)
            .width((frame.width - 10) / 4)
            .height(height)
            .margin(5)
        
        travellingLabel.pin
            .after(of: foodLabel, aligned: .center)
            .width((frame.width - 40) / 2)
            .height(height)
            .margin(5)

        clothesLabel.pin
            .below(of: filmsLabel, aligned: .center)
            .width((frame.width - 10) / 4)
            .height(height)
            .margin(5)

        gamesLabel.pin
            .after(of: clothesLabel, aligned: .center)
            .width((frame.width - 10) / 4)
            .height(height)
            .margin(5)

        othersLabel.pin
            .after(of: gamesLabel, aligned: .center)
            .width((frame.width - 10) / 4)
            .height(height)
            .margin(5)

    }
    
    func configureLabels() {
        [filmsLabel, foodLabel, clothesLabel, travellingLabel, gamesLabel, othersLabel].forEach {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelIsTapped(_:)))
            $0.addGestureRecognizer(gestureRecognizer)
            $0.isUserInteractionEnabled = true
            $0.layer.cornerRadius = 20
            $0.textColor = .white
            $0.textAlignment = .center
            $0.backgroundColor = .lightGray
            $0.clipsToBounds = true
        }
        filmsLabel.backgroundColor = .darkPink
    }
    
    // MARK: - Handlers
    
    @objc
    func labelIsTapped(_ gesture: UITapGestureRecognizer) {
        guard let tappedLabel = gesture.view as? UILabel else {
            return
        }
        guard let previousView = viewWithTag(selectedSphereTag) else {
            return
        }
        previousView.backgroundColor = .lightGray
        tappedLabel.backgroundColor = .darkPink
        selectedSphereTag = tappedLabel.tag
    }

}
