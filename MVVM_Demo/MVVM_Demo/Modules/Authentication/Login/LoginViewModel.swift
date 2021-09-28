//
//  LoginViewModel.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import Foundation

protocol LoginViewModelProtocol {
    var feedback: Dynamic<String> {get}
    var isLoading: Dynamic<Bool> {get}
    var isSuccess: Dynamic<Bool> {get}
    
    func loginButtonTapped(phoneNumber: String?, password: String?)
}

class LoginViewModel: LoginViewModelProtocol {
    fileprivate var usecase = LoginUsecase()
    
    var feedback: Dynamic<String> = Dynamic("")
    var isLoading: Dynamic<Bool> = Dynamic(false)
    var isSuccess: Dynamic<Bool> = Dynamic(false)
    
    init() {}
    
    func loginButtonTapped(phoneNumber: String?, password: String?) {
        guard let phoneNumber = phoneNumber, phoneNumber.isEmpty == false else {
            feedback.value = "Enter phone number"
            return
        }

        guard let password = password, password.isEmpty == false else {
            feedback.value = "Enter password"
            return
        }
        
        feedback.value = ""
        isLoading.value = true
        
        usecase.login(withPhone: phoneNumber, password: password) { success in
            self.isLoading.value = false
            
            if success {
                self.feedback.value = "Login Success"
                self.isSuccess.value = true
            } else {
                self.feedback.value = "Password other than 0"
                self.isSuccess.value = false
            }
        }
    }
}
