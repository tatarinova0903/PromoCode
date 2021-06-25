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
	private let output: MainViewOutput

    private let tableView = UITableView()
    
    init(output: MainViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
    
    private func configureTableView() {
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let res = output.getDataCount()
        return res
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let promoCode = output.getPromoCode(forIndex: indexPath.row)
        cell.textLabel?.text = promoCode.service
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: MainViewInput {
    func reloadData() {
        tableView.reloadData()
    }
    
}
