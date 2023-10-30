//
//  CategoryTableViewCell.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let id = "CategoryTableViewCell"

    var backGraundImageView: UIImageView = {
        let backGraundImageView = UIImageView(image: UIImage(named: "UserPhoto"))
        backGraundImageView.contentMode = .scaleAspectFit
        backGraundImageView.layer.cornerRadius = 10
        backGraundImageView.clipsToBounds = true
        return backGraundImageView
    }()

//    private lazy var nameLabel: UILabel = {
//        let cityLabel = UILabel()
//        cityLabel.font = UIFont(name: "SFProDisplay-Medium", size: 20)
//        cityLabel.textColor = .black
//        return cityLabel
//    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        backgroundColor = .yellow
        addSubviews([backGraundImageView])
        installingСonstraints()
    }
}

extension CategoryTableViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            backGraundImageView.topAnchor.constraint(equalTo: topAnchor),
            backGraundImageView.leadingAnchor.constraint(equalTo: leftAnchor),
            backGraundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backGraundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)])
    }
}
