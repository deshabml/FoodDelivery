//
//  MainViewController.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class MainViewController: UIViewController {

    private let mainView: MainView = MainView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
    }
}
