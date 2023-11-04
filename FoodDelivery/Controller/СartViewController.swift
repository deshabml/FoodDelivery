//
//  СartViewController.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class CartViewController: UIViewController {

    var presenter: CartScreenViewPresenterProtocol!
    private let mainView: CartView = CartView()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        presenter.showContent()
    }
}

extension CartViewController: CartScreenViewProtocol {

    func setContent(mainModel: CartModel) {
        mainView.setContent(mainModel: mainModel)
        mainView.setupCompletion { [unowned self] in
            mainModel.clearCart()
            let alert = UIAlertController(title: "Спасибо за покупку!", message: "Ваш заказ принят в работу", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel ))
            self.present(alert, animated: true, completion: nil)
        }
        mainModel.setupComletion { [unowned self] in
            self.mainView.setupButtonActive()
            self.mainView.tableView.reloadData()
        }
        view = mainView
    }
}
