//
//  MainViewController.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit
import PinLayout

final class MainViewController: UIViewController {
    
    // MARK: - Properties
    
	private let output: MainViewOutput
    
    private var collectionView: PromocodeCollectionView = {
        let collectionView = PromocodeCollectionView()
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.isHidden = true
        activityIndicator.color = .darkPink
        return activityIndicator
    }()
    
    private let sphereTextField: CustomSphereTextField = {
        let sphereTextField = CustomSphereTextField(insets: LayersConstants.textFieldInsets)
        sphereTextField.textAlignment = .center
        sphereTextField.text = Spheres.films.inRussian()
        return sphereTextField
    }()
    
    private let addButton = CustomAddButton()
    
    private let promocodeView: PromocodeView = {
        let promocodeView = PromocodeView()
        promocodeView.layer.cornerRadius = 20
        promocodeView.isHidden = true
        return promocodeView
    }()
    
    private var blurBackgroundView: UIView = {
        let view = UIView()
        view.alpha = 0
        return view
    }()
    
    private lazy var tapPromocodeRecognizer = UITapGestureRecognizer(target: self, action: #selector(promocodeViewAnimation))
    
    private struct LayersConstants {
        static let screenWidth = UIScreen.main.bounds.width
        static let textFieldInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        static let collectionViewConstant: CGFloat = 15
        static let horisontalPadding: CGFloat = 10
    }
    
    private var isPromocodeViewHidden = true
    
    // MARK: - Init

    init(output: MainViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Главная"
        view.backgroundColor = .darkGray
        output.viewDidLoad()
        [collectionView, sphereTextField, activityIndicator, addButton, blurBackgroundView, promocodeView].forEach{ view.addSubview($0) }
        configureCollectionView()
        configurePicker()
        configureAddButton()
        promocodeView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addButton.pin
            .top(view.pin.safeArea.top + 10)
            .right(LayersConstants.horisontalPadding)
            .size(CGSize(width: view.frame.height / LayersConstants.collectionViewConstant, height: view.frame.height / LayersConstants.collectionViewConstant))
        sphereTextField.pin
            .before(of: addButton, aligned: .center)
            .left()
            .margin(LayersConstants.horisontalPadding)
            .height(view.frame.height / LayersConstants.collectionViewConstant)
        collectionView.pin
            .below(of: sphereTextField)
            .marginTop(5)
            .horizontally(LayersConstants.horisontalPadding)
            .bottom(view.pin.safeArea.bottom)
        activityIndicator.pin.center().sizeToFit()
        blurBackgroundView.pin
            .all()
        promocodeView.pin
            .center()
            .size(CGSize(width: view.frame.width * 0.8, height: view.frame.width * 0.5))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureGradient()
        configureCornerRadius()
        configureBlur()
    }
    
    // MARK: - Configures
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configurePicker() {
        let spherePicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: LayersConstants.screenWidth, height: 216))
        spherePicker.delegate = self
        spherePicker.dataSource = self
        sphereTextField.setInputViewSpherePicker(with: spherePicker, target: self, selector: #selector(doneSphereTapped))
    }
    
    private func configureAddButton() {
        addButton.addTarget(self, action: #selector(addButtonDidTapped), for: .touchUpInside)
    }
    
    private func configureGradient() {
        addButton.gradientlayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        let endY = 0.5 + addButton.frame.size.width / addButton.frame.size.height / 2
        addButton.gradientlayer.endPoint = CGPoint(x: 1, y: endY)
        addButton.layer.sublayers?.forEach({ $0.cornerRadius = addButton.bounds.width / 2 })
    }
    
    private func configureCornerRadius() {
        sphereTextField.makeRound()
    }
    
    private func configureBlur() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = view.bounds
        blurredEffectView.alpha = 0.8
        
        blurBackgroundView.addSubview(blurredEffectView)
    }
    
    // MARK: - Handlers
    
    @objc
    private func promocodeViewAnimation() {
        var alpha: CGFloat = 0
        dismissKeyboard()
        
        if isPromocodeViewHidden == true {
            alpha = 1
            promocodeView.isHidden = false
            blurBackgroundView.isHidden = false
            blurBackgroundView.addGestureRecognizer(tapPromocodeRecognizer)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseIn]) { [weak self] in
            self?.blurBackgroundView.alpha = alpha
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.promocodeView.alpha = alpha
        } completion: { [weak self] _ in
            guard let self = self else { return }
            if self.isPromocodeViewHidden == true {
                self.promocodeView.isHidden = true
                self.blurBackgroundView.gestureRecognizers?.removeAll()
            }
        }
        isPromocodeViewHidden.toggle()
    }
    
    @objc
    private func addButtonDidTapped() {
        print(#function)
    }
    
    @objc
    private func doneSphereTapped() {
        if let spherePicker = self.sphereTextField.inputView as? UIPickerView {
            output.doneSphereTapped(sphere: Spheres.allCases[spherePicker.selectedRow(inComponent: 0)])
        }
        self.sphereTextField.resignFirstResponder()
    }
}

// MARK: - Extensions

extension MainViewController: MainViewInput {
    func reloadData() {
        collectionView.reloadData()
    }
    
    func addToFavoritesDidTapped(promocode: PromoCode) {
        output.addToFavoritesDidTapped(promocode: promocode)
    }
    
    func changeCollectionCell(atIndex index: Int, with promocode: PromoCode) {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? PromocodeCollectionViewCell else {
            return
        }
        cell.configureCell(with: promocode)
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func startActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func setSphere(with sphere: Spheres) {
        sphereTextField.text = sphere.inRussian()
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.getDataCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PromocodeCollectionViewCell.description(), for: indexPath) as? PromocodeCollectionViewCell else {
            return UICollectionViewCell()
        }
        let promocode = output.getPromoCode(forIndex: indexPath.row)
        cell.delegate = self
        cell.configureCell(with: promocode)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - LayersConstants.horisontalPadding * 2, height: view.frame.height / 8)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        promocodeView.configure(with: output.getPromoCode(forIndex: indexPath.row))
        promocodeViewAnimation()
    }
}

extension MainViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Spheres.allCases.count
    }

}

extension MainViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Spheres.allCases[row].inRussian()
    }

}
