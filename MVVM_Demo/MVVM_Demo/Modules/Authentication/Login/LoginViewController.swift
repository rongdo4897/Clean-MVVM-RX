//
//  LoginViewController.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import UIKit

//MARK: - Outlet, Override
class LoginViewController: UIViewController {
    @IBOutlet weak var tfPhone: UITextField!
    @IBOutlet weak var tfPass: UITextField!
    @IBOutlet weak var activityLogin: UIActivityIndicatorView!
    @IBOutlet weak var lblFeedback: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    var viewModel: LoginViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponents()
        customizeComponents()
        setUpdata()
    }
    
    @IBAction func btnLoginTapped(_ sender: Any) {
        viewModel?.loginButtonTapped(phoneNumber: tfPhone.text,
                                     password: tfPass.text)
    }
}

//MARK: - Action - Obj
extension LoginViewController {
    
}

//MARK: - Các hàm khởi tạo, Setup
extension LoginViewController {
    private func initComponents() {
        
    }
}

//MARK: - Customize
extension LoginViewController {
    private func customizeComponents() {
    }
}

//MARK: - Các hàm chức năng
extension LoginViewController {
    func setUpdata() {
        viewModel?.feedback.bindAndFire({ [weak self] message in
            self?.lblFeedback.text = message
        })
        
        viewModel?.isLoading.bindAndFire({ isLoading in
            if isLoading {
                self.activityLogin.startAnimating()
                self.btnLogin.isHidden = true
            } else {
                self.activityLogin.stopAnimating()
                self.btnLogin.isHidden = false
            }
        })
        
        viewModel?.isSuccess.bindAndFire({ isSuccess in
            if isSuccess {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    guard let vc = RouterType.tabbar.getVc() as? TabbarViewController else {return}
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        })
    }
}
