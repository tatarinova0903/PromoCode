//
//  CustomTabBarViewController.swift
//  PromoCode
//
//  Created by Дарья on 24.06.2021.
//  
//

import UIKit

final class CustomTabBarViewController: UITabBarController {
	private let output: CustomTabBarViewOutput

    init(output: CustomTabBarViewOutput) {
        self.output = output

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
		super.viewDidLoad()
	}
}

extension CustomTabBarViewController: CustomTabBarViewInput {
}
