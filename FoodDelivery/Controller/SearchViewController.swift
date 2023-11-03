//
//  SearchViewController.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class SearchViewController: UIViewController {

    var presenter: SearchScreenViewPresenterProtocol!
    private lazy var isStartScreen: Bool = true
    private let mainView: SearchView = SearchView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting(isStartScreen: isStartScreen)
        presenter.showContent {
            self.mainView.tagsCollectionView.reloadData()
        }
//        view = mainView
    }
}

extension SearchViewController {

    func setupIsNotStartScreen() {
        isStartScreen = false
    }
}

extension SearchViewController: SearchScreenViewProtocol {

    func setContent(mainModel: SearchModel) {
        mainView.setContent(mainModel: mainModel)
        view = mainView
    }
}
