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
        presenter.showContent()
        view = mainView
    }
}

extension MainViewController: MainScreenViewProtocol {

    func setContent(mainModel: MainModel) {
        
    }
}

import SwiftUI

struct MainViewProvider: PreviewProvider {

    static var previews: some View {
        NavigationStack {
            ContainerView().edgesIgnoringSafeArea(.all)
        }
    }

    struct ContainerView: UIViewControllerRepresentable{
        typealias UIViewControllerType = MainViewController
        let vc = MainViewController()
        func makeUIViewController(context: Context) -> MainViewController {
            return vc
        }

        func updateUIViewController(_ uiViewController: MainViewController, context: Context) { }
    }
}
