//
//  Product.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

import Foundation

struct Dish: Decodable {

    let id: Int
    var name: String
    var price: Int
    var weight: Int
    var description: String
    var imageUrl: String
    var tegs: [String]
    var isLike: Bool?
}

struct Dishes: Decodable {

    var dishes: [Dish]
}
