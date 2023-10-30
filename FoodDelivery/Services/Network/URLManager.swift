//
//  URLManager.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

import Foundation

final class URLManager {

    static let shared = URLManager()
    private let tunnel = "https://"
    private let server = Server.prod

    private init() { }

    func createUrl(endpoint: EndPoint) -> URL? {
        let urlStr = tunnel + server.rawValue + endpoint.rawValue
        return URL(string: urlStr)
    }
}

enum Server: String {

    case prod = "run.mocky.io"
}

enum EndPoint: String {

    case categorys = "/v3/b3e33160-24b4-4961-926f-6956d679551b"
    case products = "/v3/6b8ad64e-5441-47d4-bf45-fd267adf1f5d"
}
