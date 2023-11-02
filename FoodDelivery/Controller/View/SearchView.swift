//
//  SearchView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 02.11.2023.
//

import UIKit

class SearchView: UIView {

    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {

    @objc func selectedValue(target: UISegmentedControl) {
//        if target == levelsSegmentControl {
//            let index = target.selectedSegmentIndex
//            logo.image = logos[index]
//            switch index {
//                case 0:
//                    difficultyLevel = .Beginner
//                case 1:
//                    difficultyLevel = .smartGuy
//                case 2:
//                    difficultyLevel = .beast
//                default:
//                    print("Что-то, пошло не по плану!")
//            }
//        }
    }
}
