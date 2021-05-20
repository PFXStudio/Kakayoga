//
//  AppDelegate.swift
//  KakaYoga
//
//  Created by nyon on 2021/05/19.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = ProfileTableViewController()
        let navigationController = UINavigationController(rootViewController: rootViewController)
        if let window = window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        return true
    }
}

