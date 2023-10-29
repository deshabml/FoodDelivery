//
//  SceneDelegate.swift
//  FoodDelivery
//
//  Created by Лаборатория on 29.10.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: winScene)
        window.rootViewController = creatTabBar()
        window.makeKeyAndVisible()
        self.window = window
    }
}

extension SceneDelegate {

    func createMainController() -> UINavigationController {
        let mvc = UINavigationController(rootViewController: MainViewController())
        mvc.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "HomeBar"), tag: 0)
        return mvc
    }

    func createSearchController() -> UINavigationController {
        let svc = UINavigationController(rootViewController: SearchViewController())
        svc.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(named: "SaerchBar"), tag: 1)
        return svc
    }

    func createCartController() -> UINavigationController {
        let cvc = UINavigationController(rootViewController: CartViewController())
        cvc.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "CartBar"), tag: 1)
        return cvc
    }

    func createAccounthController() -> UINavigationController {
        let avc = UINavigationController(rootViewController: AccountViewController())
        avc.tabBarItem = UITabBarItem(title: "Аккаунт", image: UIImage(named: "AccountBar"), tag: 1)
        return avc
    }


    func creatTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createMainController(),
                                  createSearchController(),
                                  createCartController(),
                                  createAccounthController()]
        tabBar.tabBar.backgroundColor = .white
        tabBar.tabBar.unselectedItemTintColor = UIColor(named: "BarUnSelected")
        tabBar.tabBar.tintColor = UIColor(named: "BarColor")
        tabBar.tabBar.selectedItem?.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "SFProDisplay-Medium", size: 10)!], for: .normal)
        tabBar.selectedIndex = 0
        return tabBar
    }
}

