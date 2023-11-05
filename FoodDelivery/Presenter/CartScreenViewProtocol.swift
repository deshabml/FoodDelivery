//
//  CartScreenViewProtocol.swift
//  FoodDelivery
//
//  Created by Лаборатория on 04.11.2023.
//

import UIKit

protocol CartScreenViewProtocol {

    func setContent(mainModel: CartModel)
}

protocol CartScreenViewPresenterProtocol {

    init(view: CartScreenViewProtocol, mainModel: CartModel)

    func showContent()
}

class CartScreenPresenter: CartScreenViewPresenterProtocol {

    let view: CartScreenViewProtocol
    let mainModel: CartModel

    required init(view: CartScreenViewProtocol, mainModel: CartModel) {
        self.view = view
        self.mainModel = mainModel
    }

    func showContent() {
        view.setContent(mainModel: mainModel)
    }
}

final class CartModel {

    var productsInCart: [(dish: Dish, count: Int, image: UIImage)] = [] {
        didSet {
            completion?()
            completionTabBarVolume?()
        }
    }
    var itogPrice: Int {
        var sum = 0
        productsInCart.forEach { product in
            sum += product.dish.price * product.count
        }
        return sum
    }
    var cartBadgeValue: Int {
        var sum = 0
        productsInCart.forEach { product in
            sum += product.count
        }
        return sum
    }
    private var completion: (() -> ())?
    private var completionTabBarVolume: (() -> ())?


    func clearCart() {
        productsInCart = []
    }

    func addProducts(dish: Dish) {
        for index in 0 ..< productsInCart.count {
            guard productsInCart[index].dish.id != dish.id  else {
                productsInCart[index].count += 1
                return
            }
        }
        guard let image = UIImage(systemName: "square.dashed") else { return }
        productsInCart.append((dish: dish, count: 1, image: image))
        getImage(dish: dish)
    }

    func deleteCountProduct(dish: Dish) {
        var idexDelete: Int? = nil
        for index in 0 ..< productsInCart.count {
            if productsInCart[index].dish.id == dish.id {
                idexDelete = index
            }
        }
        guard let idexDelete else { return }
        guard productsInCart[idexDelete].count <= 1 else {
            productsInCart[idexDelete].count -= 1
            return
        }
        productsInCart = productsInCart.filter { $0.dish.id != dish.id }
    }

    func setupComletion(completion: @escaping () -> ()) {
        self.completion = completion
    }

    func setupCompletionTabBarVolume(completionTabBarVolume: @escaping () -> ()) {
        self.completionTabBarVolume = completionTabBarVolume
    }

    private func getImage(dish: Dish) {
        Task {
            do {
                let image = try await NetworkServiceAA.shared.downloadImage(url: dish.imageUrl)
                DispatchQueue.main.async { [unowned self] in
                    for index in 0 ..< self.productsInCart.count {
                        if dish.id == self.productsInCart[index].dish.id {
                            self.productsInCart[index].image = image
                        }
                    }
                    completion?()
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
