//
//  MainView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class MainView: UIView {

    var mainModel: MainModel?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.id)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()

    init() {
        super.init(frame: CGRect())
        setuptableView()
        backgroundColor = .white
        addSubviews([tableView])
        installingСonstraints()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 30.0) {
//            print("AP OP")
//            self.tableView.reloadData()
//        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainView {

    func setContent(mainModel: MainModel) {
        self.mainModel = mainModel
    }

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}

extension MainView: UITableViewDataSource, UITableViewDelegate {

    func setuptableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainModel else { return 4 }
        return mainModel.categories.сategories.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.id, for: indexPath) as! CategoryTableViewCell
//        cell.setupCell(guest: guests[indexPath.row]) { index in
//            self.guests[indexPath.row].numberGuests = index
//        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UIScreen.main.bounds.height / 4
    }
}
