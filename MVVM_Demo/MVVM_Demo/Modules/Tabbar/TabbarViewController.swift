//
//  TabbarViewController.swift
//  ChatApp Tutorial
//
//  Created by Hoang Lam on 10/06/2021.
//

import UIKit

class TabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabbar()
    }
    
    private func createTabbar() {
        let dashboard = RouterType.dashboard.getVc()
        let github = RouterType.github.getVc()
        
        let dashboardNav = UINavigationController(rootViewController: dashboard)
        dashboardNav.isNavigationBarHidden = true
        let githubNav = UINavigationController(rootViewController: github)
        githubNav.isNavigationBarHidden = true
                
        let dashboardItem = UITabBarItem(title: "Dashboard", image: UIImage(systemName: "house.fill"), tag: 0)
        let githubItem = UITabBarItem(title: "Network", image: UIImage(systemName: "network"), tag: 1)
        
        dashboardNav.tabBarItem = dashboardItem
        githubNav.tabBarItem = githubItem
        
        self.viewControllers = [dashboardNav, githubNav]
    }
}
