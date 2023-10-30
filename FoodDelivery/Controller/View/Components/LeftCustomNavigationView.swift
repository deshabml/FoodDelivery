//
//  CustomNavigationView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

import UIKit

class LeftCustomNavigationView: UIView {

    private lazy var locationImageView: UIImageView = {
        let locationImageView = UIImageView(image: UIImage(named: "Location"))
        locationImageView.contentMode = .scaleAspectFit
        return locationImageView
    }()

    private lazy var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.font = UIFont(name: "SFProDisplay-Regular", size: 18)
        cityLabel.textColor = .black
        return cityLabel
    }()

    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        dateLabel.textColor = .secondaryLabel
        return dateLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews([locationImageView,
                     cityLabel,
                     dateLabel])
        installingСonstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LeftCustomNavigationView {

    func setupView(city: String, date: String) {
        cityLabel.text = city
        dateLabel.text = date
    }

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            locationImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            locationImageView.bottomAnchor.constraint(equalTo: centerYAnchor),
            locationImageView.widthAnchor.constraint(equalToConstant: 24),
            locationImageView.heightAnchor.constraint(equalToConstant: 24),
            cityLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 4),
            cityLabel.topAnchor.constraint(equalTo: locationImageView.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: cityLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 4)])
    }
}
