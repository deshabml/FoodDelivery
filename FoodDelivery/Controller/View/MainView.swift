//
//  MainView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class MainView: UIView {

    var mainModel: MainModel?
    private var completion: ((String) -> ())?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.id)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()

    init() {
        super.init(frame: CGRect())
        setuptableView()
        backgroundColor = .white
        addSubviews([tableView])
        installingСonstraints()
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
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 14),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }

    func setupCompletion(complrtion: @escaping (String)->()) {
        self.completion = complrtion
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
        guard let mainModel else { return cell }
        cell.setupCell(category: mainModel.categories.сategories[indexPath.row],
                       image: mainModel.images[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (UIScreen.main.bounds.height - 200) / CGFloat(mainModel?.categories.сategories.count ?? 4)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        completion?(mainModel?.categories.сategories[indexPath.row].name ?? "")
    }
}
