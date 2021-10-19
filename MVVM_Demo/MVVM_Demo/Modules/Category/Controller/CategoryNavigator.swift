//
//  CategoryNavigator.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 19/10/2021.
//

import Foundation
import UIKit

protocol CategoryNavigatorType {
    func toMealByCategory(data: Category)
}

class CategoryNavigator: CategoryNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toMealByCategory(data: Category) {
        
    }
}
