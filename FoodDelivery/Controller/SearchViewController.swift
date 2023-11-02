//
//  SearchViewController.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class SearchViewController: UIViewController {

    private lazy var isStartScreen: Bool = true
    private let mainView: SearchView = SearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting(isStartScreen: isStartScreen)
        view = mainView
    }
}

extension SearchViewController {

    func setupIsNotStartScreen() {
        isStartScreen = false
    }
}
