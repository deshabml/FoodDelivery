//
//  Product.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

import Foundation

struct Dish: Decodable {

    let id: Int
}

enum TegsDish: String {

    case salads = "Салаты"
    case withRice = "С рисом"
    case withFish = "С рыбой"
}
