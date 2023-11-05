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

    func navigationBarSetting(isStartScreen: Bool = true) {
        if isStartScreen {
            let leftBarButtonView = LeftCustomNavigationView()
            let locationService = LocationService()
            locationService.getCityName { [unowned self] cityName in
                leftBarButtonView.setupView(city: cityName, 
                                            date: self.date)
            }
            let leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonView)
            navigationItem.leftBarButtonItem = leftBarButtonItem
            let rightBarButtonItem = UIBarButtonItem(customView: RightCustomNavigationView())
            navigationItem.rightBarButtonItem = rightBarButtonItem
        } else {
            let backButton = UIBarButtonItem(image: UIImage(named: "BackButtonImage"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(goBack))
            backButton.tintColor = .black
            navigationItem.leftBarButtonItem = backButton
            let label = UILabel()
            label.backgroundColor = .clear
            label.font = UIFont(name: "SFProDisplay-Medium", size: 18)
            label.textAlignment = .center
            label.textColor = .black
            label.text = title
            navigationItem.titleView = label
        }
    }

    @objc
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
}
