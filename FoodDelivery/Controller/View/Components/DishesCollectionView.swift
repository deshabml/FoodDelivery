//
//  DishesCollectionView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 03.11.2023.
//

import UIKit

class DishesCollectionView: UICollectionView {

    var mainModel: SearchModel?

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        register(TagsViewCell.self, forCellWithReuseIdentifier: TagsViewCell.id)
        dataSource = self
        delegate = self
        showsVerticalScrollIndicator = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DishesCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let mainModel else { return 0 }
        return mainModel.activeDishes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsViewCell.id, for: indexPath) as? TagsViewCell else { return TagsViewCell()}
        guard let mainModel else { return cell }
        cell.setupCell(textLabel: mainModel.activeDishes[indexPath.row].name,
                       directionIndex: indexPath.row,
                       isActive: false)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard let mainModel else {
            return CGSize(width: 70, height: 70)
//        }
//        let label = UILabel(frame: CGRect.zero)
//        label.text = mainModel.tags[indexPath.row]
//        label.sizeToFit()
//        return CGSize(width: label.frame.width + 16, height: 35)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        guard let mainModel else { return }
//        for index in 0 ..< mainModel.isActiveTags.count {
//            guard let cell = collectionView.cellForItem(at: [0, index]) as? TagsViewCell else { break }
//            if mainModel.tags[index] == mainModel.tags[indexPath.row] {
//                mainModel.isActiveTags[index] = true
//                cell.setupSelect(isActive: true)
//            } else {
//                mainModel.isActiveTags[index] = false
//                cell.setupSelect(isActive: false)
//            }
//        }
    }
}

extension DishesCollectionView {

    func setContent(mainModel: SearchModel) {
        self.mainModel = mainModel
    }
}
