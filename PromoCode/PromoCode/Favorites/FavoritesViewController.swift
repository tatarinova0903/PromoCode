//
//  FavoritesViewController.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit
import PinLayout
import CoreData

final class FavoritesViewController: UIViewController {
    
    // MARK: - Properties
    
	private let output: FavoritesViewOutput
    
    private var promocodeCollectionView: PromocodeCollectionView = {
        let collectionView = PromocodeCollectionView()
        return collectionView
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.barTintColor = .darkGray
        searchBar.placeholder = "Что Вы ищете?"
        return searchBar
    }()
    
    private struct LayersConstants {
        static let screenWidth = UIScreen.main.bounds.width
        static let textFieldInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        static let horisontalPadding: CGFloat = 10
        static let spheresCollectionViewHeight: CGFloat = UIScreen.main.bounds.height / 15
    }

    // MARK: - Init

    init(output: FavoritesViewOutput) {
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
        title = "Избранное"
        view.backgroundColor = .darkGray
        output.viewDidLoad()
        [searchBar, promocodeCollectionView].forEach({ view.addSubview($0) })
        configureCollectionView()
        searchBar.delegate = self
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchBar.pin
            .top(view.safeAreaInsets.top + 5)
            .horizontally(LayersConstants.horisontalPadding)
            .height(40)
        promocodeCollectionView.pin
            .below(of: searchBar)
            .marginTop(5)
            .horizontally(LayersConstants.horisontalPadding)
            .bottom(to: view.edge.bottom)
    }
    
    // MARK: - Configures

    private func configureCollectionView() {
        promocodeCollectionView.register(FavPromocodeCollectionViewCell.self, forCellWithReuseIdentifier: FavPromocodeCollectionViewCell.description().description)
        promocodeCollectionView.delegate = self
        promocodeCollectionView.dataSource = self
    }
    
    // MARK: - Handlers
    
}

// MARK: - Extensions

extension FavoritesViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        output.getNumberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        output.getNumberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavPromocodeCollectionViewCell.description(), for: indexPath) as? FavPromocodeCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        let favpromocode = output.getPromoCode(forIndexPath: indexPath)
        cell.configureCell(with: favpromocode)
        return cell
    }
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2 - LayersConstants.horisontalPadding * 2, height: view.frame.height / 8)
    }
}

extension FavoritesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 1) {
            cell.alpha = 1.0
        }
    }
}
extension FavoritesViewController: FavoritesViewInput {
    func reloadData() {
        promocodeCollectionView.reloadData()
    }
}

extension FavoritesViewController: FavPromocodeViewCellOutput {
    func addToFavoritesDidTap(promocode: FavPromoCode) {
        output.delete(promocode: promocode)
    }
}

extension FavoritesViewController: NSFetchedResultsControllerDelegate {

//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            if let newIndexPath_ = newIndexPath {
//                promocodeCollectionView.reloadItems(at: [newIndexPath_])
//            }
//        case .delete:
//            if let newIndexPath_ = newIndexPath {
//                promocodeCollectionView.reloadItems(at: [newIndexPath_])
//            }
//        case .update:
//            if let newIndexPath_ = newIndexPath {
//                promocodeCollectionView.reloadItems(at: [newIndexPath_])
//            }
//        default:
//            break
//        }
//    }
     
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        promocodeCollectionView.reloadData()
    }
}

extension FavoritesViewController: UISearchBarDelegate {
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

