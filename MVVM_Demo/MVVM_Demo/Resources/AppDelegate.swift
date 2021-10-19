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
        print(Environment.rootURL)
        
//        let dashboard = RouterType.category.getVc()
//        let nav = UINavigationController(rootViewController: dashboard)
//        nav.isNavigationBarHidden = true
//        window?.rootViewController = nav
        
        let navigator = CategoryNavigator(
            navigationController: UINavigationController())
        let usecase = CategoryUseCase()
        let viewModel = CategoryViewModel(navigator: navigator, usecase: usecase)
        let viewController = CategoryViewController.instantiate()
        viewController.viewModel = viewModel
        
        let nav = UINavigationController(rootViewController: viewController)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        
        return true
    }

}

