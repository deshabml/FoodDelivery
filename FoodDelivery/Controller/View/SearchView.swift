//
//  SearchView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 02.11.2023.
//

import UIKit

class SearchView: UIView {

    var mainModel: SearchModel?

    let tagsCollectionView: TagsCollectionView = {
        let tagsCollectionView = TagsCollectionView()
        return tagsCollectionView
    }()

    let dishesCollectionView: DishesCollectionView = {
        let dishesCollectionView = DishesCollectionView()
        return dishesCollectionView
    }()

    init() {
        super.init(frame: CGRect())
        backgroundColor = .white
        addSubviews([tagsCollectionView,
                     dishesCollectionView])
        installingСonstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {

    func setContent(mainModel: SearchModel) {
        self.mainModel = mainModel
        tagsCollectionView.setContent(mainModel: mainModel) { [unowned self] in
            self.dishesCollectionView.reloadData()
        }
        dishesCollectionView.setContent(mainModel: mainModel)
    }

    private func installingСonstraints() {
        NSLayoutConstraint.activate([
            tagsCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            tagsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tagsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tagsCollectionView.heightAnchor.constraint(equalToConstant: 35),
            dishesCollectionView.topAnchor.constraint(equalTo: tagsCollectionView.bottomAnchor, constant: 16),
            dishesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dishesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dishesCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)])
    }
}
