//
//  TagsCollectionView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 02.11.2023.
//

import UIKit

class TagsCollectionView: UICollectionView {

    var tags = ["Все меню", "Салаты", "С рисом", "С рыбой"]
    var active = [false, false, false, false]

    private var numberActive: [Int] = []

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        register(TagsViewCell.self, forCellWithReuseIdentifier: TagsViewCell.id)
        dataSource = self
        delegate = self
        showsHorizontalScrollIndicator = false
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
                label.text = tags[indexPath.row]
                label.sizeToFit()
                return CGSize(width: label.frame.width + 16, height: 35)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        for index in 0 ..< active.count {
            guard let cell = collectionView.cellForItem(at: [0, index]) as? TagsViewCell else { break }
            if tags[index] == tags[indexPath.row] {
                active[index] = true
                numberActive.append(cell.indexCell)
                cell.setupSelect(isActive: true)
            } else {
                active[index] = false
                numberActive = numberActive.filter {$0 != indexPath.item}
                cell.setupSelect(isActive: false)
            }
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

