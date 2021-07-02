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
    
    private let tableView = UITableView()
    private let addButton = UIButton()

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
        title = "Избранное"
        output.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(addButton)
        configureTableView()
        configureAddButton()
	}
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin
            .top()
            .left()
            .right()
            .bottom(200)
        addButton.pin
            .below(of: tableView, aligned: .center)
            .size(CGSize(width: 200, height: 50))
    }
    
    // MARK: - Configures

    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureAddButton() {
        addButton.backgroundColor = .blue
        addButton.setTitle("Add", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonDidTaped), for: .touchUpInside)
    }
    
    // MARK: - Handlers
    
    @objc
    private func addButtonDidTaped() {
        CoreDataManager.shared.addPromoCode(promocode: PromoCode(id: "ID", service: "OKKO", promocode: "&^GHU", description: "", date: Date()))
        tableView.reloadData()
    }
}

// MARK: - Extensions

extension FavoritesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        output.getNumberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output.getNumberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let promoCode = output.getPromoCode(forIndexPath: indexPath)
        cell.textLabel?.text = "\(promoCode.service) + \(promoCode.id)"
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate {
    
}

extension FavoritesViewController: FavoritesViewInput {
    func reloadData() {
        tableView.reloadData()
    }
}

extension FavoritesViewController: NSFetchedResultsControllerDelegate {
    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.beginUpdates()
//    }
//
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        switch type {
//        case .insert:
//            if let newIndexPath_ = newIndexPath {
//                tableView.insertRows(at: [newIndexPath_], with: .fade)
//            }
//        case .delete:
//            if let newIndexPath_ = newIndexPath {
//                tableView.deleteRows(at: [newIndexPath_], with: .fade)
//            }
//        case .update:
//            if let newIndexPath_ = newIndexPath {
//                tableView.reloadRows(at: [newIndexPath_], with: .fade)
//            }
//        case .move:
//            if let oldIndexPath = indexPath, let newIndexPath_ = newIndexPath {
//                tableView.moveRow(at: oldIndexPath, to: newIndexPath_)
//            }
//        default:
//            break
//        }
//    }
     
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        tableView.endUpdates()
        tableView.reloadData()
    }
}

