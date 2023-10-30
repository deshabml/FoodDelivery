//
//  RightCustomNavigationView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

import UIKit

class RightCustomNavigationView: UIView {

    private lazy var userImageView: UIImageView = {
        let userImageView = UIImageView(image: UIImage(named: "UserPhoto"))
        userImageView.contentMode = .scaleAspectFit
        userImageView.layer.cornerRadius = 22
        userImageView.clipsToBounds = true
        return userImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([userImageView])
        installingСonstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RightCustomNavigationView {
    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            userImageView.widthAnchor.constraint(equalToConstant: 44),
            userImageView.heightAnchor.constraint(equalToConstant: 44),
            userImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            userImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
