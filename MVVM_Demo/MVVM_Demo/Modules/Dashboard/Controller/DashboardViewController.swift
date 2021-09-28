//
//  DashboardViewController.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import UIKit

//MARK: - Outlet, Override
class DashboardViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    var viewModel: DashboardViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initComponents()
        customizeComponents()
        setUpdata()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        viewModel?.refreshButtonTapped()
    }
}

//MARK: - Action - Obj
extension DashboardViewController {
    
}

//MARK: - Các hàm khởi tạo, Setup
extension DashboardViewController {
    private func initComponents() {
        
    }
}

//MARK: - Customize
extension DashboardViewController {
    private func customizeComponents() {
        
    }
}

//MARK: - Các hàm chức năng
extension DashboardViewController {
    private func setUpdata() {
        viewModel?.customer.bindAndFire({ [weak self] customer in
            guard let strongSelf = self else {
                return
            }
            strongSelf.lblName.text = customer.name
            strongSelf.lblStatus.text = customer.status
        })
    }
}
