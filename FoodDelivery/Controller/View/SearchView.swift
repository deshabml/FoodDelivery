//
//  SearchView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 02.11.2023.
//

import UIKit

class SearchView: UIView {

    var tags = ["Все меню", "Салаты", "С рисом", "С рыбой"]

    private lazy var tagsCollectionView: TagsCollectionView = {
        let tagsCollectionView = TagsCollectionView()
        return tagsCollectionView
    }()

    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        addSubviews([tagsCollectionView])
        installingСonstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            tagsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tagsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagsCollectionView.heightAnchor.constraint(equalToConstant: 68)])
    }
}