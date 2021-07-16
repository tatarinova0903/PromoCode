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
    
    private let spheresContainer: SpheresContainer = {
        let view = SpheresContainer()
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
        
        dismissKeyboard()
        view.backgroundColor = .darkGray
        
        view.addSubview(whiteCard)
        [textFieldsContainer, spheresContainer, addButton].forEach({ whiteCard.addSubview($0) })
        [serviceTextField, promocodeTextField, descriptionTextField, dateTextField].forEach({ textFieldsContainer.addSubview($0) })
        
        addButton.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        whiteCard.pin
            .horizontally(20)
            .vertically(80)
        
        addButton.pin
            .bottomRight(10)
            .size(CGSize(width: 60, height: 60))
        
        textFieldsContainer.pin
            .horizontally()
            .top(10)
            .height(round(whiteCard.frame.height * 0.6))
        
        spheresContainer.pin
            .above(of: addButton)
            .below(of: textFieldsContainer)
            .marginTop(10)
            .horizontally()
        
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
        configureGradient()
    }
    
    // MARK: - Configures
    
    private func configureCornerRadius() {
        addButton.makeRound()
    }
    
    private func configureGradient() {
        addButton.gradientlayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        let endY = 0.5 + addButton.frame.size.width / addButton.frame.size.height / 2
        addButton.gradientlayer.endPoint = CGPoint(x: 1, y: endY)
        addButton.layer.sublayers?.forEach({ $0.cornerRadius = addButton.bounds.width / 2 })
    }
    
    // MARK: - Handlers
    
    @objc
    func addButtonDidTapped() {
        output.addButtonDidTapped(service: serviceTextField.text, promocode: promocodeTextField.text, description: descriptionTextField.text, date: dateTextField.text, sphere: Spheres.allCases[spheresContainer.selectedSphereTag])
    }
}


// MARK: - Extensions

extension AddPromocodeViewController: AddPromocodeViewInput {
    func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
