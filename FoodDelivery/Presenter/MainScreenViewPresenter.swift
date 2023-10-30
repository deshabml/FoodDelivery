//
//  ScreenViewPresenter.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import Foundation

protocol MainScreenViewProtocol {

    func setContent(mainModel: MainModel)
}

protocol MainScreenViewPresenterProtocol {

    init(view: MainScreenViewProtocol, mainModel: MainModel)

    func showContent()
}

class MainScreenPresenter: MainScreenViewPresenterProtocol {

    let view: MainScreenViewProtocol

    let mainModel: MainModel

    required init(view: MainScreenViewProtocol, mainModel: MainModel) {
        self.view = view
        self.mainModel = mainModel
    }

    func showContent() {
        view.setContent(mainModel: mainModel)
    }
}

struct MainModel {

}
