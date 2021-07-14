//
//  AddPromocodeViewController.swift
//  PromoCode
//
//  Created by Дарья on 14.07.2021.
//

import UIKit

class AddPromocodeViewController: UIViewController {
    
    // MARK: - Properties
    
    private let output: AddPromocodeViewOutput
    
    private let whiteCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.white.cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 0.4
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    
    private let addButton: CustomAddButton = {
        let button = CustomAddButton()
        return button
    }()
    
    private let serviceTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        textField.placeholder = "Название сервиса"
        return textField
    }()
    
    private let promocodeTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        textField.placeholder = "Промокод"
        return textField
    }()
    
    private let descriptionTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        textField.placeholder = "Описание"
        return textField
    }()
    
    private let dateTextField: CustomTextField = {
        let textField = CustomTextField(insets: UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10))
        textField.placeholder = "Дата окончания действия"
        return textField
    }()
    
    private let textFieldsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private struct LayerConstants {
        static let horizontalPadding: CGFloat = 10
        static let textFieldsSpacing: CGFloat = 30
    }
    
    // MARK: - Init
    
    init(output: AddPromocodeViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        
        view.addSubview(whiteCard)
        [textFieldsContainer, addButton].forEach({ whiteCard.addSubview($0) })
        [serviceTextField, promocodeTextField, descriptionTextField, dateTextField].forEach({ textFieldsContainer.addSubview($0) })
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        whiteCard.pin
            .horizontally(20)
            .vertically(80)
        
        addButton.pin
            .bottomRight()
            .size(CGSize(width: 50, height: 50))
        
        textFieldsContainer.pin
            .above(of: addButton)
            .horizontally()
            .top()
        
        serviceTextField.pin
            .top(LayerConstants.textFieldsSpacing)
            .horizontally(LayerConstants.horizontalPadding)
            .height((textFieldsContainer.frame.height - LayerConstants.textFieldsSpacing * 5) / 4)
        
        descriptionTextField.pin
            .below(of: serviceTextField)
            .horizontally(LayerConstants.horizontalPadding)
            .marginTop(LayerConstants.textFieldsSpacing)
            .height(of: serviceTextField)
        
        promocodeTextField.pin
            .below(of: descriptionTextField)
            .horizontally(LayerConstants.horizontalPadding)
            .marginTop(LayerConstants.textFieldsSpacing)
            .height(of: serviceTextField)
        
        dateTextField.pin
            .below(of: promocodeTextField)
            .horizontally(LayerConstants.horizontalPadding)
            .marginTop(LayerConstants.textFieldsSpacing)
            .height(of: serviceTextField)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureCornerRadius()
    }
    
    // MARK: - Configures
    
    private func configureCornerRadius() {
        addButton.makeRound()
    }
}


// MARK: - Extensions

extension AddPromocodeViewController: AddPromocodeViewInput {
    
}
