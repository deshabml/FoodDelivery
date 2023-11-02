//
//  TagsCollectionView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 02.11.2023.
//

import UIKit

class TagsCollectionView: UICollectionView {

    var tags = ["Все меню", "Салаты", "С рисом", "С рыбой"]

    private var numberActive: [Int] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 0)
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        super.init(frame: .zero, collectionViewLayout: layout)
        register(TagsViewCell.self, forCellWithReuseIdentifier: TagsViewCell.id)
        dataSource = self
        delegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TagsCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsViewCell.id, for: indexPath) as? TagsViewCell else { return TagsViewCell()}
        cell.setupCell(textLabel: tags[indexPath.item], directionIndex: indexPath.item, isActive: numberActive.contains(indexPath.item))
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
                label.text = tags[indexPath.item]
                label.sizeToFit()
                return CGSize(width: label.frame.width + 48, height: 44)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? TagsViewCell else { return }
        if !cell.isActive {
            numberActive.append(cell.indexCell)
            cell.setupSelect(isActive: true)
        } else {
            numberActive = numberActive.filter {$0 != indexPath.item}
            cell.setupSelect(isActive: false)
        }
    }
}

//extension OneCollectionView {
//
//    func setupCollectionView(directions: [String]) {
//        self.directions = directions
//    }
//
//}

