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
    
    private var promocodeCollectionView: PromocodeCollectionView = {
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
    
    private let spheresCollectionView: SpheresCollectionView = {
        let collectionView = SpheresCollectionView()
        return collectionView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .darkGray
        searchBar.placeholder = "Что Вы ищете?"
        return searchBar
    }()
        
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
        static let horisontalPadding: CGFloat = 10
        static let spheresCollectionViewHeight: CGFloat = round(UIScreen.main.bounds.height / 15)
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
        hideKeyboardWhenTappedAround()
        output.viewDidLoad()
        view.backgroundColor = .darkGray
        [searchBar, promocodeCollectionView, spheresCollectionView, activityIndicator, blurBackgroundView, promocodeView].forEach{ view.addSubview($0) }
        promocodeView.delegate = self
        searchBar.delegate = self
        
        configureNavigationBar()
        configureCollectionView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        searchBar.pin
            .top(view.pin.safeArea.top + 10)
            .horizontally(LayersConstants.horisontalPadding)
            .height(LayersConstants.spheresCollectionViewHeight)
        spheresCollectionView.pin
            .below(of: searchBar)
            .marginTop(5)
            .horizontally(LayersConstants.horisontalPadding)
            .height(LayersConstants.spheresCollectionViewHeight)
        promocodeCollectionView.pin
            .below(of: spheresCollectionView)
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
        configureBlur()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output.viewDidAppear()
    }
    
    // MARK: - Configures
    
    private func configureNavigationBar() {
        title = "Главная"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addPromocodeButtonDidTapped))
        navigationItem.rightBarButtonItem?.tintColor = .darkPink
    }
    
    private func configureCollectionView() {
        promocodeCollectionView.register(PromocodeCollectionViewCell.self, forCellWithReuseIdentifier: PromocodeCollectionViewCell.description().description)
        promocodeCollectionView.delegate = self
        promocodeCollectionView.dataSource = self
        spheresCollectionView.delegate = self
        spheresCollectionView.dataSource = self
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
    private func addPromocodeButtonDidTapped() {
        output.addPromocodeButtonDidTapped()
    }
}

// MARK: - Extensions

extension MainViewController: MainViewInput {
    func reloadData(at index: Int) {
        promocodeCollectionView.insertItems(at: [IndexPath(row: index, section: 0)])
    }
    
    func reloadData() {
        promocodeCollectionView.reloadData()
    }
    
    func changePromocodeCollectionCell(atIndex index: Int, with promocode: PromoCode) {
        guard let cell = promocodeCollectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? PromocodeCollectionViewCell else {
            return
        }
        cell.configureCell(with: promocode)
    }
    
    func changeSphereCollectionCell(atOldIndex oldIndex: Int?, atNewIndex newIndex: Int) {
        if let oldIndex_ = oldIndex,
           let cellForOldSphere = spheresCollectionView.cellForItem(at: IndexPath(row: oldIndex_, section: 0)) as? SpheresCollectionViewCell {
            cellForOldSphere.configureCell(isChosen: false)
        }
        if let cellForNewSphere = spheresCollectionView.cellForItem(at: IndexPath(row: newIndex, section: 0)) as? SpheresCollectionViewCell {
            cellForNewSphere.configureCell(isChosen: true)
        }
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func startActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

extension MainViewController: PromocodeViewCellOutput {
    func addToFavoritesDidTap<T>(promocode: T) {
        guard let promocode = promocode as? PromoCode else { return }
        output.addToFavoritesDidTapped(promocode: promocode)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _ = collectionView as? PromocodeCollectionView else {
            return output.getSpheresCount()
        }
        return output.getPromocodesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let _ = collectionView as? PromocodeCollectionView else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SpheresCollectionViewCell.description(), for: indexPath) as? SpheresCollectionViewCell else {
                return UICollectionViewCell()
            }
            let sphere = output.getSphere(forIndex: indexPath.row)
            cell.delegate = self
            cell.configureCell(with: sphere, isChosen: sphere == output.currentSphere)
            return cell
        }
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
        guard let _ = collectionView as? PromocodeCollectionView else {
            let width = output.getSphereCellLength(forIndex: indexPath.row)
            return CGSize(width: width, height: LayersConstants.spheresCollectionViewHeight)
        }
        return CGSize(width: view.frame.width / 2 - LayersConstants.horisontalPadding * 2, height: view.frame.height / 8)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _ = collectionView as? PromocodeCollectionView else {
            output.currentSphere = output.getSphere(forIndex: indexPath.row)
            return
        }
        promocodeView.configure(with: output.getPromoCode(forIndex: indexPath.row))
        promocodeViewAnimation()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let _ = collectionView as? PromocodeCollectionView else { return }
        cell.alpha = 0
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchQuery = searchBar.text else { return }
        output.searchForQuery(searchQuery)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            output.didEndSearching()
        }
    }
}
