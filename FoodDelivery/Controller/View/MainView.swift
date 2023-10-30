//
//  MainView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class MainView: UIView {

//    private lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.dataSource = self
//        tableView.delegate = self
////        tableView.register(GuestTableViewCell.self, forCellReuseIdentifier: GuestTableViewCell.id)
//        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
//        return tableView
//    }()

    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {
    func setContent(mainModel: MainModel) {
    }
}

//extension MainView: UITableViewDataSource, UITableViewDelegate {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//1
//    }
//    
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//    
//
//}
