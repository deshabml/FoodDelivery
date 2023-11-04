//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class MainViewController: UIViewController {

    var presenter: MainScreenViewPresenterProtocol!
    private let mainView: MainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        presenter.showContent { [unowned self] in
            self.mainView.tableView.reloadData()
        }
    }
}

extension MainViewController: MainScreenViewProtocol {

    func setContent(mainModel: MainModel) {
        mainView.setContent(mainModel: mainModel)
        mainView.setupCompletion { [unowned self] name in
            let mainModel = mainModel.searchModel
            let view = SearchViewController()
            let presenter = SearchScreenPresenter(view: view, mainModel: mainModel)
            view.presenter = presenter
            view.setupIsNotStartScreen()
            view.title = name
            self.navigationController?.pushViewController(view, animated: true)
        }
        view = mainView
    }
}
