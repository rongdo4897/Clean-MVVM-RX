//
//  AppRouter.swift
//  AddContact
//
//  Created by Huong Nguyen on 3/3/21.
//

import UIKit

enum RouterType {
    case category
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
        case .category:
            let vc = UIStoryboard(name: Constants.category, bundle: nil).instantiateViewController(ofType: CategoryViewController.self)
//            let viewModel = GithubViewModel()
//            vc.viewModel = viewModel
            return vc
        }
    }
}
