//
//  DashboardViewModel.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import Foundation
import UIKit

protocol DashboardViewModelProtocol {
    var customer: Dynamic<Customer> {get}
    var isFetching: Dynamic<Bool> {get}
    
    func refreshButtonTapped()
}

class DashboardViewModel: DashboardViewModelProtocol {
    fileprivate var usecase = DashboardUseCase()
    
    var customer: Dynamic<Customer> = Dynamic(Customer(name: "John Appleseed", status: "ACTIVE"))
    var isFetching: Dynamic<Bool> = Dynamic(false)
    
    init() {
        
    }
    
    func refreshButtonTapped() {
        isFetching.value = true
        usecase.excute(completion: { customer in
            self.customer.value = customer
            self.isFetching.value = false
        })
    }
}
