//
//  NetworkError.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

enum NetworkError: Error {

    case badUrl
    case badResponse
    case invalidDecoding
    case noImage
}
