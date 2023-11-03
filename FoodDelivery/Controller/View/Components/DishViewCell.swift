//
//  DishViewCell.swift
//  FoodDelivery
//
//  Created by Лаборатория on 03.11.2023.
//

import UIKit

class DishViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "ColorCell")
        layer.cornerRadius = 12
//        contentView.addSubview(label)
//        installingСonstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
//        installingСonstraints()
    }

}
