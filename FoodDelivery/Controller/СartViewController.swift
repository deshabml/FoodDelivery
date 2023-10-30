//
//  СartViewController.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        view.backgroundColor = .gray
    }
}

import SwiftUI

struct CartViewProvider: PreviewProvider {

    static var previews: some View {
        NavigationStack {
            ContainerView().edgesIgnoringSafeArea(.all)
        }
    }

    struct ContainerView: UIViewControllerRepresentable{
        typealias UIViewControllerType = CartViewController
        let vc = CartViewController()
        func makeUIViewController(context: Context) -> CartViewController {
            return vc
        }

        func updateUIViewController(_ uiViewController: CartViewController, context: Context) { }
    }
}
