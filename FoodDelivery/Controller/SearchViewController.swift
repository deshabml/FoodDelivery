//
//  SearchViewController.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        view.backgroundColor = .lightGray
    }
}

import SwiftUI

struct SearchViewProvider: PreviewProvider {

    static var previews: some View {
        NavigationStack {
            ContainerView().edgesIgnoringSafeArea(.all)
        }
    }

    struct ContainerView: UIViewControllerRepresentable{
        typealias UIViewControllerType = SearchViewController
        let vc = SearchViewController()
        func makeUIViewController(context: Context) -> SearchViewController {
            return vc
        }

        func updateUIViewController(_ uiViewController: SearchViewController, context: Context) { }
    }
}
