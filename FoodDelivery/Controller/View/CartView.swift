//
//  CartView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 04.11.2023.
//

import UIKit

class CartView: UIView {

    var mainModel: CartModel?
    private var completion: (() -> ())?

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.id)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        return tableView
    }()

    private lazy var toPayButton: UIButton = {
        let toPayButton = UIButton()
        toPayButton.configuration = UIButton.Configuration.filled()
        toPayButton.configuration?.baseBackgroundColor = UIColor(named: "BarColor")
        toPayButton.layer.cornerRadius = 10
        toPayButton.setTitle("Оплатить \(mainModel?.itogPrice ?? 0) ₽", for: .normal)
        toPayButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        toPayButton.tintColor = .white
        toPayButton.addTarget(self, action: #selector(toPayButtonAction), for: .touchUpInside)
        toPayButton.isHidden = true
        return toPayButton
    }()

    private lazy var noProducktsButtonBackGraund: UIView  = {
        let noProducktsButtonBackGraund = UIView()
        noProducktsButtonBackGraund.backgroundColor = .systemGray6
        noProducktsButtonBackGraund.layer.cornerRadius = 10
        noProducktsButtonBackGraund.isHidden = false
        return noProducktsButtonBackGraund
    }()

    private lazy var noProducktsButtonText: UILabel = {
        let noProducktsButton = UILabel()
        noProducktsButton.text = "Оплатить 0 ₽"
        noProducktsButton.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        noProducktsButton.textColor = .secondaryLabel
        noProducktsButton.isHidden = false
        return noProducktsButton
    }()

    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        addSubviews([toPayButton,
                     noProducktsButtonBackGraund,
                     noProducktsButtonText,
                     tableView])
        installingСonstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CartView {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            toPayButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            toPayButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            toPayButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            toPayButton.heightAnchor.constraint(equalToConstant: 48),
            noProducktsButtonBackGraund.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            noProducktsButtonBackGraund.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            noProducktsButtonBackGraund.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            noProducktsButtonBackGraund.heightAnchor.constraint(equalToConstant: 48),
            noProducktsButtonText.centerXAnchor.constraint(equalTo: noProducktsButtonBackGraund.centerXAnchor),
            noProducktsButtonText.centerYAnchor.constraint(equalTo: noProducktsButtonBackGraund.centerYAnchor)])
    }

    func setContent(mainModel: CartModel) {
        self.mainModel = mainModel
        mainModel.setupComletion { [unowned self] in
            if mainModel.productsInCart.isEmpty {
                toPayButton.isHidden = true
                noProducktsButtonBackGraund.isHidden = false
                noProducktsButtonText.isHidden = false
            } else {
                self.toPayButton.setTitle("Оплатить \(mainModel.itogPrice) ₽", for: .normal)
                toPayButton.isHidden = false
                noProducktsButtonBackGraund.isHidden = true
                noProducktsButtonText.isHidden = true
            }
            tableView.reloadData()
        }
    }

    @objc
    func toPayButtonAction() {
        completion?()
    }

    func setupCompletion(completion: @escaping ()->()) {
        self.completion = completion
    }
}

extension CartView: UITableViewDataSource, UITableViewDelegate {

    func setuptableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainModel else { return 0 }
        return mainModel.productsInCart.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.id, for: indexPath) as! CategoryTableViewCell
        guard let mainModel else { return cell }
        cell.backgroundColor = .orange
//        cell.setupCell(category: mainModel.categories.сategories[indexPath.row],
//                       image: mainModel.images[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (UIScreen.main.bounds.height - 200) / CGFloat(4)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
