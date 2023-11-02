//
//  TagsCollectionViewCell.swift
//  FoodDelivery
//
//  Created by Лаборатория on 02.11.2023.
//

import UIKit

class TagsViewCell: UICollectionViewCell {

    static let id = "TagsViewCell"

    var isActive: Bool = false

    var indexCell: Int!

    var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont(name: "medium", size: 14)
        label.textColor = UIColor(named: "ColorButton")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "ColorCell")
        layer.cornerRadius = 12
        contentView.addSubview(label)
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

extension TagsViewCell {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24)
        ])
    }

    func setupCell(textLabel: String, directionIndex: Int, isActive: Bool) {
        label.text = textLabel
        indexCell = directionIndex
        if isActive {
            backgroundColor = UIColor(named: "BarColor")
            label.textColor = .white
        } else {
            backgroundColor = UIColor(named: "TagsBackColor")
            label.textColor = .black
        }
    }

    func setupSelect(isActive: Bool) {
        self.isActive = isActive
        if isActive {
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.backgroundColor = UIColor(named: "BarColor")
            }) {_ in
                UIView.animate(withDuration: 0.2, delay: 0, animations: {
                    self.label.textColor = .white
                })
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, animations: {
                self.backgroundColor = UIColor(named: "TagsBackColor")
            }) {_ in
                UIView.animate(withDuration: 0.2, delay: 0, animations: {
                    self.label.textColor = .black
                })
            }
        }
    }
}
