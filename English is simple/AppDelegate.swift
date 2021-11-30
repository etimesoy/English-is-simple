//
//  AppDelegate.swift
//  English is simple
//
//  Created by Руслан on 27.11.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let tabBarController = UITabBarController()
        
        let savedWordsNavigationController = UINavigationController(rootViewController: SavedWordsViewController())
        savedWordsNavigationController.navigationBar.prefersLargeTitles = true
        savedWordsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        tabBarController.addChild(savedWordsNavigationController)
        
        let loadWordsNavigationController = UINavigationController(rootViewController: LoadWordsViewController())
        loadWordsNavigationController.navigationBar.prefersLargeTitles = true
        loadWordsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        tabBarController.addChild(loadWordsNavigationController)
        
        window?.rootViewController = tabBarController
        return true
    }

}

