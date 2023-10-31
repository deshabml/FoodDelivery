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
        mainView.setupCompletion { [unowned self] in
            let svc = SearchViewController()
            self.navigationController?.pushViewController(svc, animated: true)
        }
        view = mainView
    }
}
