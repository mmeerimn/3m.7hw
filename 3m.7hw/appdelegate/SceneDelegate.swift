//
//  SceneDelegate.swift
//  3m.6hw
//
//  Created by Meerim Mamatkadyrova on 5/6/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let mainVC = MainViewController()
        
        let tabOneBarItem = UITabBarItem(title: nil,
                                         image: UIImage(systemName: "list.bullet"),
                                         selectedImage: UIImage(systemName: "list.bullet"))
        
        mainVC.tabBarItem = tabOneBarItem
        
        let secondVC = DetailViewController()
        
        let tabTwoeBarItem = UITabBarItem(title: nil,
                                          image: UIImage(systemName: "bell"),
                                          selectedImage: UIImage(systemName: "bell"))
        
        secondVC.tabBarItem = tabTwoeBarItem
        
        let navController2 = UINavigationController(rootViewController:  secondVC)
        
        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [mainVC, navController2]
        tabbarController.tabBar.backgroundColor = .white
        
        window.rootViewController = tabbarController
        
        self.window = window
        self.window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}
