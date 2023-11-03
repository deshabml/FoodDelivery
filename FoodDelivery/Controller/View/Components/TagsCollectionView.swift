//
//  TagsCollectionView.swift
//  FoodDelivery
//
//  Created by Лаборатория on 02.11.2023.
//

import UIKit

class TagsCollectionView: UICollectionView {

    var mainModel: SearchModel?
    private var completion: (() -> ())?

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
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
        guard let mainModel else { return 0 }
        return mainModel.tags.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsViewCell.id, for: indexPath) as? TagsViewCell else { return TagsViewCell()}
        guard let mainModel else { return cell }
        cell.setupCell(textLabel: mainModel.tags[indexPath.row],
                       directionIndex: indexPath.row,
                       isActive: mainModel.isActiveTags[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let mainModel else {
            return CGSize(width: 10, height: 35)
        }
        let label = UILabel(frame: CGRect.zero)
        label.text = mainModel.tags[indexPath.row]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 16, height: 35)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let mainModel else { return }
        for index in 0 ..< mainModel.isActiveTags.count {
            guard let cell = collectionView.cellForItem(at: [0, index]) as? TagsViewCell else { break }
            if mainModel.tags[index] == mainModel.tags[indexPath.row] {
                mainModel.isActiveTags[index] = true
                cell.setupSelect(isActive: true)
            } else {
                mainModel.isActiveTags[index] = false
                cell.setupSelect(isActive: false)
            }
            completion?()
        }
    }
}

extension TagsCollectionView {
    
    func setContent(mainModel: SearchModel, completion: @escaping ()->()) {
        self.mainModel = mainModel
        self.completion = completion
    }
}

