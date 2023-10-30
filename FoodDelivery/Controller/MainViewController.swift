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
        presenter.showContent()
    }
}

extension MainViewController: MainScreenViewProtocol {

    func setContent(mainModel: MainModel) {
        mainView.setContent(mainModel: mainModel)
        view = mainView
    }
}
