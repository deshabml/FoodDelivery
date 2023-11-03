//
//  DishesCollectionView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 03.11.2023.
//

import UIKit

class DishesCollectionView: UICollectionView {

    var mainModel: SearchModel?
    let sideSquareSize = (UIScreen.main.bounds.width - 48) / 3

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        register(DishViewCell.self, forCellWithReuseIdentifier: DishViewCell.id)
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishViewCell.id, for: indexPath) as? DishViewCell else { return DishViewCell()}
        guard let mainModel else { return cell }
        cell.setupCell(textLabel: mainModel.activeDishes[indexPath.row].name,
                       Image: mainModel.images[indexPath.row], sideSize: sideSquareSize)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: sideSquareSize, height: sideSquareSize + 40)
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
