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

    private let tableView = UITableView()
    
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
        output.viewDidLoad()
        view.addSubview(tableView)
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.pin
            .all()
    }
    
    // MARK: - Configures
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.register(PromoCodeTableViewCell.self, forCellReuseIdentifier: PromoCodeTableViewCell.description())
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Handlers
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

extension MainViewController: MainViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
    func addToFavoritesDidTapped(promocode: PromoCode) {
        print(promocode.service)
    }
}
