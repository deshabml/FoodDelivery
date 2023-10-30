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
        let backGraundImageView = UIImageView()
        backGraundImageView.contentMode = .scaleAspectFill
        backGraundImageView.layer.cornerRadius = 10
        backGraundImageView.clipsToBounds = true
        return backGraundImageView
    }()

    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont(name: "SFProDisplay-Medium", size: 20)
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 0
        return nameLabel
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
        addSubviews([backGraundImageView,
                     nameLabel])
        installingСonstraints()
    }

    func setupCell(category: Category, image: UIImage) {
        backGraundImageView.image = image
        nameLabel.text = category.name
    }
}

extension CategoryTableViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            backGraundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            backGraundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backGraundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backGraundImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            nameLabel.topAnchor.constraint(equalTo: backGraundImageView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: backGraundImageView.leadingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 160)])
    }
}
