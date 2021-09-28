//
//  AppDelegate.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 22/09/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let dashboard = RouterType.login.getVc()
        let nav = UINavigationController(rootViewController: dashboard)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        
        return true
    }

}

