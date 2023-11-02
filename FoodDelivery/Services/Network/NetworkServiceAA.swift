//
//  NetworkServiceAA.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

import Foundation
import UIKit

final class NetworkServiceAA {

    static let shared = NetworkServiceAA()

    private init() { }

    func getData<T: Decodable>(dataset: T) async throws -> T {
        do {
            let url = try creatUrl(dataset: dataset)
            print(url)
            do {
                let response = try await URLSession.shared.data(from: url)
                let data = response.0
                let decoder = JSONDecoder()
                print(data)
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let itog = try decoder.decode(type(of: dataset).self, from: data)
                    return itog
                } catch {
                    throw NetworkError.invalidDecoding
                }
            } catch { throw NetworkError.badResponse }
        } catch { throw NetworkError.badUrl }
    }

    private func creatUrl<T>(dataset: T) throws -> URL {
        let arrayUrl: EndPoint
        switch dataset {
            case _ as Categorys: arrayUrl = .categorys
            case _ as Dish: arrayUrl = .dishes
            default: throw NetworkError.badUrl
        }
        guard let url = URLManager.shared.createUrl(endpoint: arrayUrl) else { throw NetworkError.badUrl }
        return url
    }

    func downloadImage(url: String) async throws -> UIImage {
        guard let url = URL(string: url) else { throw NetworkError.badUrl }
        do {
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
            guard let image = UIImage(data: data) else { throw NetworkError.noImage }
            return image
        } catch { throw NetworkError.badResponse }
    }
}
