//
//  AccountViewController.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarSetting()
        view.backgroundColor = .green
    }
}

import SwiftUI

struct AccountViewProvider: PreviewProvider {

    static var previews: some View {
        NavigationStack {
            ContainerView().edgesIgnoringSafeArea(.all)
        }
    }

    struct ContainerView: UIViewControllerRepresentable{
        typealias UIViewControllerType = AccountViewController
        let vc = AccountViewController()
        func makeUIViewController(context: Context) -> AccountViewController {
            return vc
        }

        func updateUIViewController(_ uiViewController: AccountViewController, context: Context) { }
    }
}
