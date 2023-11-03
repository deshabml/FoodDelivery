//
//  SearchScreenViewProtocol.swift
//  FoodDelivery
//
//  Created by Лаборатория on 02.11.2023.
//

import UIKit

protocol SearchScreenViewProtocol {

    func setContent(mainModel: SearchModel)
}

protocol SearchScreenViewPresenterProtocol {

    init(view: SearchScreenViewProtocol, mainModel: SearchModel)

    func showContent(completion: @escaping () -> ())
}

class SearchScreenPresenter: SearchScreenViewPresenterProtocol {

    let view: SearchScreenViewProtocol

    let mainModel: SearchModel

    required init(view: SearchScreenViewProtocol, mainModel: SearchModel) {
        self.view = view
        self.mainModel = mainModel
    }

    func showContent(completion: @escaping () -> ()) {
        mainModel.setupCompletion(completion: completion)
        view.setContent(mainModel: mainModel)
    }
}

class SearchModel {

    var dishes: Dishes = Dishes(dishes: [])
    var activeDishes: [Dish] = []
    var tags: [String] = []
    var isActiveTags: [Bool] = [] {
        didSet {
            if let activeTagIndex = isActiveTags.firstIndex(of: true) {
                self.activeDishes = dishes.dishes.filter { $0.tegs.contains(tags[activeTagIndex]) }
            }
        }
    }
    var images: [UIImage] = []
    private var completion: (() -> ())?

    init() {
        getDishs()
    }

    func getDishs() {
        Task {
            do {
                let dishes = try await NetworkServiceAA.shared.getData(dataset: dishes)
                DispatchQueue.main.async { [unowned self] in
                    self.dishes = dishes
                    dishes.dishes.forEach { dish in
                        dish.tegs.forEach { tag in
                            if !self.tags.contains(tag) {
                                self.tags.append(tag)
                                self.isActiveTags.append(false)
                            }
                        }
                    }
                    if !self.isActiveTags.isEmpty {
                        isActiveTags[0] = true
                    }
                    for _ in 0 ..< dishes.dishes.count {
                        guard let image = UIImage(systemName: "square.dashed") else { break }
                        self.images.append(image)
                    }
                    self.getImages()
                    completion?()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func setupCompletion(completion: @escaping () -> ()) {
        self.completion = completion
    }

    func getImages() {
        for index in 0 ..< dishes.dishes.count {
            Task {
                do {
                    let image = try await NetworkServiceAA.shared.downloadImage(url: dishes.dishes[index].imageUrl)
                    DispatchQueue.main.async { [unowned self] in
                        self.images[index] = image
                        completion?()
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}

