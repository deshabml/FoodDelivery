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

final class SearchModel {

    var dishes: Dishes = Dishes(dishes: [])
    var images: [UIImage] = [] {
        didSet {
            setupAtiveElements()
        }
    }
    var activeDishes: [Dish] = []
    var activeImages: [UIImage] = []
    var tags: [String] = []
    var isActiveTags: [Bool] = [] {
        didSet {
            setupAtiveElements()
        }
    }
    var activeDish: Dish = Dish(id: 0,
                                name: "",
                                price: 0,
                                weight: 0,
                                description: "",
                                imageUrl: "",
                                tegs: [])
    var activeImage: UIImage = UIImage()
    private var completion: (() -> ())?

    init() {
        getDishs()
    }

    private func getDishs() {
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
                    for _ in 0 ..< dishes.dishes.count {
                        guard let image = UIImage(systemName: "square.dashed") else { break }
                        self.images.append(image)
                    }
                    if !self.isActiveTags.isEmpty {
                        isActiveTags[0] = true
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

    func setupActiveDish(activeDish: Dish, activeImage: UIImage) {
        self.activeDish = activeDish
        self.activeImage = activeImage
    }

    func setupLike() {
        if activeDish.isLike ?? false {
            activeDish.isLike = false
        } else {
            activeDish.isLike = true
        }
        for index in 0 ..< dishes.dishes.count {
            if activeDish.id == dishes.dishes[index].id {
                dishes.dishes[index].isLike = (activeDish.isLike ?? false)
            }
        }
        for index in 0 ..< activeDishes.count {
            if activeDish.id == activeDishes[index].id {
                activeDishes[index].isLike = (activeDish.isLike ?? false)
            }
        }
    }

    private func setupAtiveElements() {
        if let activeTagIndex = isActiveTags.firstIndex(of: true) {
            self.activeDishes = []
            self.activeImages = []
            for index in 0 ..< dishes.dishes.count {
                if dishes.dishes[index].tegs.contains(tags[activeTagIndex]) {
                    self.activeDishes.append(dishes.dishes[index])
                    self.activeImages.append(images[index])
                }
            }
        }
    }

    private func getImages() {
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

