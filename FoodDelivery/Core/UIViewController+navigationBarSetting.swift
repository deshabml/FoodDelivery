//
//  CustomNavigationBarProtocol.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

import UIKit

extension UIViewController {

    private var date: String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM, yyyy"
        return formatter.string(from: currentDate)
    }

    func navigationBarSetting() {
        let leftBarButtonView = LeftCustomNavigationView()
        let locationService = LocationService()
        locationService.getCityName { [unowned self] cityName in
            leftBarButtonView.setupView(city: cityName, date: self.date)
        }
        let leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonView)
        navigationItem.leftBarButtonItem = leftBarButtonItem
        let rightBarButtonItem = UIBarButtonItem(customView: RightCustomNavigationView())
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
}
