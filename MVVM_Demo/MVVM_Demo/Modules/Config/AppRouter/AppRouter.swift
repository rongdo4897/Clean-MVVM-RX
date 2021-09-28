//
//  AppRouter.swift
//  AddContact
//
//  Created by Huong Nguyen on 3/3/21.
//

import UIKit

enum RouterType {
    case tabbar
    case dashboard
    case login
    case github
}

class AppRouter {
    class func routerTo(from vc: UIViewController, router: RouterType) {
        DispatchQueue.main.async {
            vc.navigationController?.pushViewController(router.getVc(), animated: true)
        }
    }
    
//    class func setRootView() {
//        if let window = UIApplication.shared.keyWindow {
//            window.rootViewController = nil
//            let navigationController = UINavigationController(rootViewController: RouterType.overview.getVc())
//            navigationController.isNavigationBarHidden = true
//            window.rootViewController = navigationController
//            let options: UIView.AnimationOptions = .transitionCrossDissolve
//            let duration: TimeInterval = 0.3
//            UIView.transition(with: window, duration: duration, options: options, animations: {}, completion: { _ in
//                                })
//            window.makeKeyAndVisible()
//        }
//    }
}

extension RouterType {
    func getVc() -> UIViewController {
        switch self {
        case .tabbar:
            let vc = UIStoryboard(name: Constants.tabbar, bundle: nil).instantiateViewController(ofType: TabbarViewController.self)
            return vc
        case .dashboard:
            let vc = UIStoryboard(name: Constants.dashbord, bundle: nil).instantiateViewController(ofType: DashboardViewController.self)
            let viewModel = DashboardViewModel()
            vc.viewModel = viewModel
            return vc
        case .login:
            let vc = UIStoryboard(name: Constants.authentication, bundle: nil).instantiateViewController(ofType: LoginViewController.self)
            let viewModel = LoginViewModel()
            vc.viewModel = viewModel
            return vc
        case .github:
            let vc = UIStoryboard(name: Constants.github, bundle: nil).instantiateViewController(ofType: GithubViewController.self)
            let viewModel = GithubViewModel()
            vc.viewModel = viewModel
            return vc
        }
    }
}
