//
//  DishViewCell.swift
//  FoodDelivery
//
//  Created by Лаборатория on 03.11.2023.
//

import UIKit

class DishViewCell: UICollectionViewCell {

    static let id = "DishViewCell"

    private var baccgraundImageheightAnchor: NSLayoutConstraint!
    private var imageDishHeightAnchor: NSLayoutConstraint!
    private var imageDishWidthAnchor: NSLayoutConstraint!


    private lazy var baccgraundImage: UIView = {
        let baccgraundImage = UIView()
        baccgraundImage.backgroundColor = UIColor(named: "TagsBackColor")
        baccgraundImage.layer.cornerRadius = 10
        baccgraundImageheightAnchor = baccgraundImage.heightAnchor.constraint(equalToConstant: 110)
        return baccgraundImage
    }()

    private lazy var imageDish: UIImageView = {
        let imageDish = UIImageView()
        imageDish.contentMode = .scaleAspectFit
        imageDishHeightAnchor = imageDish.heightAnchor.constraint(equalToConstant: 90)
        imageDishWidthAnchor = imageDish.widthAnchor.constraint(equalToConstant: 90)
        return imageDish
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        return nameLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        addSubviews([baccgraundImage,
                    nameLabel])
        baccgraundImage.addSubviews([imageDish])
        installingСonstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        installingСonstraints()
    }
}

extension DishViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            baccgraundImage.topAnchor.constraint(equalTo: topAnchor),
            baccgraundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            baccgraundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            baccgraundImageheightAnchor,
            imageDish.centerXAnchor.constraint(equalTo: baccgraundImage.centerXAnchor, constant: 1),
            imageDish.centerYAnchor.constraint(equalTo: baccgraundImage.centerYAnchor),
            imageDishHeightAnchor,
            imageDishWidthAnchor,
            nameLabel.topAnchor.constraint(equalTo: baccgraundImage.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }

    func setupCell(textLabel: String, Image: UIImage, sideSize: CGFloat) {
        nameLabel.text = textLabel
        imageDish.image = Image
        setupSize(sideSize: sideSize)
    }

    func setupSize(sideSize: CGFloat) {
        baccgraundImageheightAnchor.isActive = false
        imageDishHeightAnchor.isActive = false
        imageDishWidthAnchor.isActive = false
        baccgraundImageheightAnchor = baccgraundImage.heightAnchor.constraint(equalToConstant: sideSize)
        imageDishHeightAnchor = imageDish.heightAnchor.constraint(equalToConstant: sideSize - 20)
        imageDishWidthAnchor = imageDish.widthAnchor.constraint(equalToConstant: sideSize - 20)
        baccgraundImageheightAnchor.isActive = true
        imageDishHeightAnchor.isActive = true
        imageDishWidthAnchor.isActive = true
        layoutIfNeeded()
    }
}
