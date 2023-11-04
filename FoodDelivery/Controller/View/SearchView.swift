//
//  SearchView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 02.11.2023.
//

import UIKit

class SearchView: UIView {

    var mainModel: SearchModel?

    let tagsCollectionView = TagsCollectionView()
    let dishesCollectionView = DishesCollectionView()

    let backView: UIView = {
        let backView = UIView(frame: UIScreen.main.bounds)
        backView.alpha = 0
        backView.backgroundColor = .black
        backView.isHidden = true
        return backView
    }()

    let backContentView: UIView = {
        let backContentView = UIView(frame: CGRect(x: UIScreen.main.bounds.width / 2,
                                                   y: UIScreen.main.bounds.height / 2,
                                                   width: 0,
                                                   height: 0))
        backContentView.backgroundColor = .white
        backContentView.layer.cornerRadius = 15
        backContentView.alpha = 0
        backContentView.isHidden = true
        backContentView.translatesAutoresizingMaskIntoConstraints = false
        return backContentView
    }()

    private lazy var baccgraundImage: UIView = {
        let baccgraundImage = UIView()
        baccgraundImage.backgroundColor = UIColor(named: "TagsBackColor")
        baccgraundImage.layer.cornerRadius = 10
        return baccgraundImage
    }()

    private lazy var imageDish: UIImageView = {
        let imageDish = UIImageView()
        imageDish.contentMode = .scaleAspectFit
        return imageDish
    }()

    lazy var addCartButton: UIButton = {
        let addCartButton = UIButton()
        addCartButton.configuration = UIButton.Configuration.filled()
        addCartButton.configuration?.baseBackgroundColor = UIColor(named: "BarColor")
        addCartButton.layer.cornerRadius = 10
        addCartButton.setTitle("Добавить в корзину", for: .normal)
        addCartButton.titleLabel?.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        addCartButton.tintColor = .white
        addCartButton.addTarget(self, action: #selector(addCartButtonAction), for: .touchUpInside)
        return addCartButton
    }()

    private lazy var exitButton: UIButton = {
        let exitButton = UIButton()
        exitButton.configuration = UIButton.Configuration.filled()
        exitButton.configuration?.baseBackgroundColor = .white
        exitButton.configuration?.image = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        exitButton.configuration?.baseForegroundColor = .black
        exitButton.layer.cornerRadius = 10
        exitButton.addTarget(self, action: #selector(exitDishView), for: .touchUpInside)
        return exitButton
    }()

    private lazy var likeButton: UIButton = {
        let likeButton = UIButton()
        likeButton.configuration = UIButton.Configuration.filled()
        likeButton.configuration?.baseBackgroundColor = .white
        likeButton.configuration?.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
        likeButton.configuration?.baseForegroundColor = (mainModel?.activeDish.isLike ?? false) ? .red : .black
        likeButton.layer.cornerRadius = 10
        likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        return likeButton
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "SFProDisplay-Medium", size: 16)
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

    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        descriptionLabel.textColor = .black
        descriptionLabel.alpha = 0.65
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()

    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        addSubviews([tagsCollectionView,
                     dishesCollectionView])
        backContentView.addSubviews([baccgraundImage,
                                     addCartButton,
                                     nameLabel,
                                     priceLabel,
                                     weightLabel,
                                     descriptionLabel])
        baccgraundImage.addSubviews([imageDish,
                                     exitButton,
                                     likeButton])
        installingСonstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {

    func setContent(mainModel: SearchModel) {
        self.mainModel = mainModel
        tagsCollectionView.setContent(mainModel: mainModel) { [unowned self] in
            self.dishesCollectionView.reloadData()
        }
        dishesCollectionView.setContent(mainModel: mainModel) { [unowned self] in
            self.createDishView()
        }
    }

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            backContentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            tagsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            tagsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagsCollectionView.heightAnchor.constraint(equalToConstant: 35),
            dishesCollectionView.topAnchor.constraint(equalTo: tagsCollectionView.bottomAnchor, constant: 16),
            dishesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dishesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dishesCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            baccgraundImage.topAnchor.constraint(equalTo: backContentView.topAnchor, constant: 16),
            baccgraundImage.leadingAnchor.constraint(equalTo: backContentView.leadingAnchor, constant: 16),
            baccgraundImage.trailingAnchor.constraint(equalTo: backContentView.trailingAnchor, constant: -16),
            baccgraundImage.heightAnchor.constraint(equalToConstant: 230),
            addCartButton.bottomAnchor.constraint(equalTo: backContentView.bottomAnchor, constant: -16),
            addCartButton.leadingAnchor.constraint(equalTo: backContentView.leadingAnchor, constant: 16),
            addCartButton.trailingAnchor.constraint(equalTo: backContentView.trailingAnchor, constant: -16),
            addCartButton.heightAnchor.constraint(equalToConstant: 48),
            imageDish.topAnchor.constraint(equalTo: baccgraundImage.topAnchor, constant: 14),
            imageDish.bottomAnchor.constraint(equalTo: baccgraundImage.bottomAnchor, constant: -14),
            imageDish.leadingAnchor.constraint(equalTo: baccgraundImage.leadingAnchor, constant: 14),
            imageDish.trailingAnchor.constraint(equalTo: baccgraundImage.trailingAnchor, constant: -14),
            exitButton.topAnchor.constraint(equalTo: baccgraundImage.topAnchor, constant: 8),
            exitButton.trailingAnchor.constraint(equalTo: baccgraundImage.trailingAnchor, constant: -8),
            exitButton.heightAnchor.constraint(equalToConstant: 40),
            exitButton.widthAnchor.constraint(equalToConstant: 40),
            likeButton.topAnchor.constraint(equalTo: baccgraundImage.topAnchor, constant: 8),
            likeButton.trailingAnchor.constraint(equalTo: exitButton.leadingAnchor, constant: -8),
            likeButton.heightAnchor.constraint(equalToConstant: 40),
            likeButton.widthAnchor.constraint(equalToConstant: 40),
            nameLabel.topAnchor.constraint(equalTo: baccgraundImage.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: backContentView.leadingAnchor, constant: 16),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: backContentView.leadingAnchor, constant: 16),
            weightLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            weightLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: backContentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: backContentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: addCartButton.topAnchor, constant: -16)
        ])
    }

    private func createDishView() {
        setupDish()
        setupColorLikeButton()
        backContentView.isHidden = false
        backView.isHidden = false
        UIView.animate(withDuration: 0.2,  animations: { [unowned self] in
            self.backView.alpha = 0.4
            self.backContentView.alpha = 1
        })
    }

    func setupDish() {
        guard let mainModel else { return }
        imageDish.image = mainModel.activeImage
        nameLabel.text = mainModel.activeDish.name
        priceLabel.text = "\(mainModel.activeDish.price) ₽"
        weightLabel.text = " · \(mainModel.activeDish.weight)г"
        descriptionLabel.text = mainModel.activeDish.description
    }

    @objc func exitDishView() {
        UIView.animate(withDuration: 0.2,  animations: { [unowned self] in
            self.backView.alpha = 0
            self.backContentView.alpha = 0
        }) {[unowned self] _ in
            UIView.animate(withDuration: 0.2,  animations: { [unowned self] in
                self.backContentView.isHidden = true
                self.backView.isHidden = true
            })
        }
    }

    private func setupColorLikeButton() {
        if mainModel?.activeDish.isLike ?? false {
            likeButton.configuration?.image = UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
            likeButton.configuration?.baseForegroundColor = .red
        } else {
            likeButton.configuration?.image = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(scale: .small))
            likeButton.configuration?.baseForegroundColor = .black
        }
    }

    @objc
    func likeButtonAction() {
        mainModel?.setupLike()
        setupColorLikeButton()
    }

    @objc
    func addCartButtonAction() {
        mainModel?.addProductToCert()
    }
}
