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
        let fvc = UINavigationController(rootViewController: MainViewController())
        fvc.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "HomeBar"), tag: 0)
        return fvc
    }

    func createSearchController() -> UINavigationController {
        let lvc = UINavigationController(rootViewController: SearchViewController())
        lvc.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(named: "SaerchBar"), tag: 1)
        return lvc
    }

    func createCartController() -> UINavigationController {
        let lvc = UINavigationController(rootViewController: CartViewController())
        lvc.tabBarItem = UITabBarItem(title: "Корзина", image: UIImage(named: "CartBar"), tag: 1)
        return lvc
    }

    func createAccounthController() -> UINavigationController {
        let lvc = UINavigationController(rootViewController: AccountViewController())
        lvc.tabBarItem = UITabBarItem(title: "Аккаунт", image: UIImage(named: "AccountBar"), tag: 1)
        return lvc
    }


    func creatTabBar() -> UITabBarController {
        let tabBar = UITabBarController()
        tabBar.viewControllers = [createMainController(),
                                  createSearchController(),
                                  createCartController(),
                                  createAccounthController()]
        tabBar.tabBar.backgroundColor = .white
        tabBar.tabBar.tintColor = UIColor(named: "ColorSet")
        tabBar.selectedIndex = 1
        return tabBar
    }
}

