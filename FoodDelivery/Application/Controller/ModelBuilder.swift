//
//  ModelBuilder.swift
//  FoodDelivery
//
//  Created by Лаборатория on 30.10.2023.
//

import UIKit

protocol Builder {

    static func createMainScreen() -> UIViewController

}

class ModelBuilder: Builder {

    private static let cartModel: CartModel = CartModel()
    private static let searchModel: SearchModel = SearchModel(cartModel: cartModel)

    static func createMainScreen() -> UIViewController {
        createTabBar()
    }

    private static func createMainController() -> UINavigationController {
        let mainModel = MainModel(searchModel: searchModel, cartModel: cartModel)
        let view = MainViewController()
        let presenter = MainScreenPresenter(view: view, mainModel: mainModel)
        view.presenter = presenter
        let mvc = UINavigationController(rootViewController: view)
        mvc.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "HomeBar"), tag: 0)
        return mvc
    }

    private static func createSearchController() -> UINavigationController {
        let mainModel = searchModel
        let view = SearchViewController()
        let presenter = SearchScreenPresenter(view: view, mainModel: mainModel)
        view.presenter = presenter
        let svc = UINavigationController(rootViewController: view)
        svc.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(named: "SaerchBar"), tag: 1)
        return svc
    }

    private static func createCartController() -> UINavigationController {
        let cvc = UINavigationController(rootViewController: CartViewController())
        cvc.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "CartBar"), tag: 1)
        return cvc
    }

    private static func createAccounthController() -> UINavigationController {
        let avc = UINavigationController(rootViewController: AccountViewController())
        avc.tabBarItem = UITabBarItem(title: "Аккаунт", image: UIImage(named: "AccountBar"), tag: 1)
        return avc
    }

    private static func createTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createMainController(),
                                  createSearchController(),
                                  createCartController(),
                                  createAccounthController()]
        tabBar.tabBar.backgroundColor = .white
        let borderView = UIView(frame: CGRect(x: 0, y: 0, width: tabBar.tabBar.bounds.width, height: 1))
        borderView.backgroundColor = UIColor(named: "TabBarBorderColor")
        tabBar.tabBar.addSubview(borderView)
        tabBar.tabBar.unselectedItemTintColor = UIColor(named: "BarUnSelected")
        tabBar.tabBar.tintColor = UIColor(named: "BarColor")
        tabBar.tabBar.selectedItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 10)!], for: .normal)
        tabBar.selectedIndex = 0
        return tabBar
    }
}
