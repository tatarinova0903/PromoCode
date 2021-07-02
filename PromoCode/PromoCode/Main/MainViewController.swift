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

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(PromoCodeTableViewCell.self, forCellReuseIdentifier: PromoCodeTableViewCell.description())
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var collectionView: CustomSpheresCollectionView = {
        let collectionView = CustomSpheresCollectionView()
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.isHidden = true
        activityIndicator.color = .systemPink
        return activityIndicator
    }()
    
    private let collectionViewConstant: CGFloat = 15
    
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
        output.viewDidLoad()
        [tableView, collectionView, activityIndicator].forEach{ view.addSubview($0) }
        configureTableView()
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.pin
            .top(view.pin.safeArea.top + 5)
            .horizontally()
            .height(view.frame.height / collectionViewConstant)
        tableView.pin
            .below(of: collectionView)
            .horizontally()
            .bottom(view.pin.safeArea.bottom)
        activityIndicator.pin.center().sizeToFit()
    }
    
    // MARK: - Configures
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

// MARK: - Extensions

extension MainViewController: MainViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func addToFavoritesDidTapped(promocode: PromoCode) {
        output.addToFavoritesDidTapped(promocode: promocode)
    }
    
    func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }
    
    func startActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let res = output.getDataCount()
        return res
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PromoCodeTableViewCell.description(), for: indexPath) as? PromoCodeTableViewCell else {
            return UITableViewCell()
        }
        let promoCode = output.getPromoCode(forIndex: indexPath.row)
        cell.delegate = self
        cell.configureCell(with: promoCode)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Spheres.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let id = PromocodeSphereCollectionViewCell.description().description
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath) as? PromocodeSphereCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: Spheres.allCases[indexPath.row].inRussian())
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 4, height: view.frame.height / collectionViewConstant)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output.currentSphere = Spheres.allCases[indexPath.row]
    }
}

