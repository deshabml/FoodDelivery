//
//  ProductInCartTableViewCell.swift
//  FoodDelivery
//
//  Created by Лаборатория on 04.11.2023.
//

import UIKit

class ProductInCartTableViewCell: UITableViewCell {

    static let id = "ProductInCartTableViewCell"

    private var completionAdd: (() -> ())?
    private var completionDelete: (() -> ())?

    private lazy var baccgraundImage: UIView = {
        let baccgraundImage = UIView()
        baccgraundImage.backgroundColor = UIColor(named: "TagsBackColor")
        baccgraundImage.layer.cornerRadius = 6
        return baccgraundImage
    }()

    private lazy var imageDish: UIImageView = {
        let imageDish = UIImageView()
        imageDish.contentMode = .scaleAspectFit
        return imageDish
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        return nameLabel
    }()

    private lazy var priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        priceLabel.textColor = .black
        priceLabel.numberOfLines = 0
        return priceLabel
    }()


    private lazy var weightLabel: UILabel = {
        let weightLabel = UILabel()
        weightLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        weightLabel.textColor = .secondaryLabel
        weightLabel.numberOfLines = 0
        return weightLabel
    }()

    private lazy var testBackView: UILabel = {
        let testBackView = UILabel()
        testBackView.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        testBackView.textColor = .clear
        testBackView.text = " "
        testBackView.numberOfLines = 0
        return testBackView
    }()

    private lazy var stackLabels: UIStackView = {
        let stackLabels = UIStackView()
        stackLabels.axis = .vertical
        stackLabels.distribution = .equalSpacing
        stackLabels.alignment = .leading
        stackLabels.spacing = 4
        stackLabels.addArrangedSubview(nameLabel)
        stackLabels.addArrangedSubview(testBackView)
        return stackLabels
    }()

    private lazy var addAndDeleteBaccgraundImage: UIView = {
        let addAndDeleteBaccgraundImage = UIView()
        addAndDeleteBaccgraundImage.backgroundColor = UIColor(named: "AddAndDeletBack")
        addAndDeleteBaccgraundImage.layer.cornerRadius = 10
        return addAndDeleteBaccgraundImage
    }()

    private lazy var countLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        priceLabel.textColor = .black
        priceLabel.numberOfLines = 0
        return priceLabel
    }()


    private lazy var imageAdd: UIButton = {
        let imageAdd = UIButton()
        imageAdd.configuration = UIButton.Configuration.filled()
        imageAdd.configuration?.baseBackgroundColor = .clear
        imageAdd.configuration?.image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        imageAdd.configuration?.baseForegroundColor = .black
        imageAdd.addTarget(self, action: #selector(imageAddActiom), for: .touchUpInside)
        return imageAdd
    }()

    private lazy var imageDelete: UIButton = {
        let imageDelete = UIButton()
        imageDelete.configuration = UIButton.Configuration.filled()
        imageDelete.configuration?.baseBackgroundColor = .clear
        imageDelete.configuration?.image = UIImage(systemName: "minus", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        imageDelete.configuration?.baseForegroundColor = .black
        imageDelete.addTarget(self, action: #selector(imageDeleteActiom), for: .touchUpInside)
        return imageDelete
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        backgroundColor = .clear
        addSubviews([baccgraundImage,
                     imageDish,
                     stackLabels,
                     addAndDeleteBaccgraundImage])
        testBackView.addSubviews([priceLabel,
                                  weightLabel])
        addAndDeleteBaccgraundImage.addSubviews([imageAdd,
                                                 countLabel,
                                                 imageDelete])
        installingСonstraints()
    }

    func setupCell(productsInCart: (dish: Dish, count: Int, image: UIImage), completionAdd: @escaping ()->(), completionDelete: @escaping ()->()) {
        self.completionAdd = completionAdd
        self.completionDelete = completionDelete
        nameLabel.text = productsInCart.dish.name
        imageDish.image = productsInCart.image
        priceLabel.text = "\(productsInCart.dish.price) ₽"
        weightLabel.text = " · \(productsInCart.dish.weight)г"
        countLabel.text = "\(productsInCart.count)"
    }
}

extension ProductInCartTableViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            baccgraundImage.heightAnchor.constraint(equalToConstant: 62),
            baccgraundImage.widthAnchor.constraint(equalToConstant: 62),
            baccgraundImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            baccgraundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackLabels.leadingAnchor.constraint(equalTo: baccgraundImage.trailingAnchor, constant: 8),
            stackLabels.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackLabels.widthAnchor.constraint(equalToConstant: 120),
            imageDish.centerYAnchor.constraint(equalTo: baccgraundImage.centerYAnchor, constant: 1),
            imageDish.centerXAnchor.constraint(equalTo: baccgraundImage.centerXAnchor, constant: 1),
            imageDish.widthAnchor.constraint(equalToConstant: 55),
            imageDish.heightAnchor.constraint(equalToConstant: 55),
            priceLabel.leadingAnchor.constraint(equalTo: testBackView.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: testBackView.topAnchor),
            weightLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
            weightLabel.topAnchor.constraint(equalTo: testBackView.topAnchor),
            addAndDeleteBaccgraundImage.heightAnchor.constraint(equalToConstant: 32),
            addAndDeleteBaccgraundImage.widthAnchor.constraint(equalToConstant: 100),
            addAndDeleteBaccgraundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            addAndDeleteBaccgraundImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            countLabel.centerXAnchor.constraint(equalTo: addAndDeleteBaccgraundImage.centerXAnchor),
            countLabel.centerYAnchor.constraint(equalTo: addAndDeleteBaccgraundImage.centerYAnchor),
            imageDelete.heightAnchor.constraint(equalToConstant: 24),
            imageDelete.widthAnchor.constraint(equalToConstant: 24),
            imageDelete.centerYAnchor.constraint(equalTo: addAndDeleteBaccgraundImage.centerYAnchor),
            imageDelete.leadingAnchor.constraint(equalTo: addAndDeleteBaccgraundImage.leadingAnchor, constant: 6),
            imageAdd.heightAnchor.constraint(equalToConstant: 24),
            imageAdd.widthAnchor.constraint(equalToConstant: 24),
            imageAdd.centerYAnchor.constraint(equalTo: addAndDeleteBaccgraundImage.centerYAnchor),
            imageAdd.trailingAnchor.constraint(equalTo: addAndDeleteBaccgraundImage.trailingAnchor, constant: -6)])
    }

    @objc
    func imageAddActiom() {
        completionAdd?()
    }

    @objc
    func imageDeleteActiom() {
        completionDelete?()
    }
}

