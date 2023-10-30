//
//  ScreenViewPresenter.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

protocol MainScreenViewProtocol {

    func setContent(mainModel: MainModel)
}

protocol MainScreenViewPresenterProtocol {

    init(view: MainScreenViewProtocol, mainModel: MainModel)

    func showContent(completion: @escaping () -> ())
}

class MainScreenPresenter: MainScreenViewPresenterProtocol {

    let view: MainScreenViewProtocol

    let mainModel: MainModel

    required init(view: MainScreenViewProtocol, mainModel: MainModel) {
        self.view = view
        self.mainModel = mainModel
    }

    func showContent(completion: @escaping () -> ()) {
        mainModel.setupCompletion(completion: completion)
        view.setContent(mainModel: mainModel)
    }
}

class MainModel {

    var categories: Categorys = Categorys(сategories: [])
    var images: [UIImage] = []
    private var completion: (() -> ())?

    init() {
        getCategories()
    }

    func getCategories() {
        Task {
            do {
                let categories = try await NetworkServiceAA.shared.getData(dataset: categories)
                DispatchQueue.main.async { [unowned self] in
                    self.categories = categories
                    for _ in 0 ..< categories.сategories.count {
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
        for index in 0 ..< categories.сategories.count {
            Task {
                do {
                    let image = try await NetworkServiceAA.shared.downloadImage(url: categories.сategories[index].imageUrl)
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
