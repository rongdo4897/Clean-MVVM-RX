//
//  DashboardUseCase.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import Foundation

class DashboardUseCase {
    func excute(completion: @escaping (Customer) ->Void) {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let name = self.randomName()
            let status = self.randomStatus()
            
            completion(Customer(name: name, status: status))
        }
    }
    
    private func randomName() -> String {
        let listFirstNames = ["John", "Paul", "Jim", "Robert", "Ann", "Kate", "Emily", "Jane"]
        let listLastNames = ["Appleseed", "Martin", "Torvalds", "Kernighan", "Ritchie", "Lovelace"]
        
        let firstName = listFirstNames.randomElement() ?? listFirstNames.first!
        let lastName = listLastNames.randomElement() ?? listLastNames.first!
        
        return firstName + " " + lastName
    }
    
    private func randomStatus() -> String {
        let listStatuses = ["ACTIVE", "EXPIRED", "UNKNOWN"]
        return listStatuses.randomElement() ?? listStatuses.first!
    }
}
