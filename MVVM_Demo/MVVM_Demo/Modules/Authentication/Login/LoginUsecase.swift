//
//  LoginUsecase.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import Foundation

class LoginUsecase {
    func login(withPhone phoneNumber: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let success = self.authenticated(phoneNumber: phoneNumber, password: password)
            
            completion(success)
        }
    }
    
    private func authenticated(phoneNumber: String, password: String) -> Bool {
        return password != "0"
    }
}
