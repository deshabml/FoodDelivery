//
//  UIView+AddSudviews.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

extension UIView {

    func addSubviews(_ arrayView: [UIView]) {
        arrayView.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
