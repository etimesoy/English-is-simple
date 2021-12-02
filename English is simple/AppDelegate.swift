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
    private let interactor = Interactor()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground

        let tabBarController = UITabBarController()
        for (viewControllerIndex, wordsViewController) in [SavedWordsViewController(), LoadWordsViewController()].enumerated() {
            let loadWordsNavigationController = UINavigationController(rootViewController: wordsViewController)
            loadWordsNavigationController.navigationBar.prefersLargeTitles = true
            let systemItem: UITabBarItem.SystemItem
            systemItem = viewControllerIndex == 0 ? .favorites : .search
            loadWordsNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: systemItem,
                                                                    tag: viewControllerIndex)
            tabBarController.addChild(loadWordsNavigationController)
        }

        if interactor.onboardingShouldBeShown {
            window?.rootViewController = OnboardingPageViewController(tabBarController)
        } else {
            window?.rootViewController = tabBarController
        }

        return true
    }

}

