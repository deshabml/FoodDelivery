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

    func showContent(completion: @escaping () -> ())
}

class CartScreenPresenter: CartScreenViewPresenterProtocol {

    let view: CartScreenViewProtocol

    let mainModel: CartModel

    required init(view: CartScreenViewProtocol, mainModel: CartModel) {
        self.view = view
        self.mainModel = mainModel
    }

    func showContent(completion: @escaping () -> ()) {
        view.setContent(mainModel: mainModel)
    }
}

final class CartModel {

    var productsInCart: [(dish: Dish, count: Int)] = []
    var itogPrice: Int {
        var sum = 0
        productsInCart.forEach { product in
            sum += product.dish.price * product.count
        }
        return sum
    }

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
        productsInCart.append((dish: dish, count: 1))
    }

    func deleteCountProduct(dish: Dish) {
        for index in 0 ..< productsInCart.count {
            if productsInCart[index].dish.id == dish.id {
                guard productsInCart[index].count <= 1 else {
                    productsInCart[index].count -= 1
                    return
                }
                productsInCart = productsInCart.filter { $0.dish.id != dish.id }
            }
        }
    }
}
