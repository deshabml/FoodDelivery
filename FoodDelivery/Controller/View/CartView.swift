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
        tableView.register(ProductInCartTableViewCell.self, forCellReuseIdentifier: ProductInCartTableViewCell.id)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
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
        setuptableView()
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

    override func layoutSubviews() {
        setupButtonActive()
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
            noProducktsButtonText.centerYAnchor.constraint(equalTo: noProducktsButtonBackGraund.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: toPayButton.topAnchor)])
    }

    func setContent(mainModel: CartModel) {
        self.mainModel = mainModel
    }

    @objc
    func toPayButtonAction() {
        completion?()
    }

    func setupCompletion(completion: @escaping ()->()) {
        self.completion = completion
    }

    private func payButtonDeActive() {
        toPayButton.isHidden = true
        noProducktsButtonBackGraund.isHidden = false
        noProducktsButtonText.isHidden = false
    }

    private func payButtonActive() {
        guard let mainModel else { return }
        toPayButton.setTitle("Оплатить \(mainModel.itogPrice) ₽", for: .normal)
        toPayButton.isHidden = false
        noProducktsButtonBackGraund.isHidden = true
        noProducktsButtonText.isHidden = true
    }

    func setupButtonActive() {
        guard let mainModel else { return }
        if mainModel.productsInCart.isEmpty {
            payButtonDeActive()
        } else {
            payButtonActive()
        }
    }
}

extension CartView: UITableViewDataSource, UITableViewDelegate {

    func setuptableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let mainModel else { return 5 }
        return mainModel.productsInCart.count
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductInCartTableViewCell.id, for: indexPath) as! ProductInCartTableViewCell
        guard let mainModel else { return cell }
        cell.setupCell(productsInCart: mainModel.productsInCart[indexPath.row]) {
            mainModel.addProducts(dish: mainModel.productsInCart[indexPath.row].dish)
        } completionDelete: {
            mainModel.deleteCountProduct(dish: mainModel.productsInCart[indexPath.row].dish)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        78
    }
}
