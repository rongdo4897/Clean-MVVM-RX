//
//  GithubViewModel.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import Foundation

protocol GithubViewModelProtocol {
    var listDataGitHub: Dynamic<[Github]> {get}
    var isRefresh: Dynamic<Bool> {get}
    
    func refreshData()
}

class GithubViewModel: GithubViewModelProtocol {
    fileprivate var usecase = GithubUseCase()
    
    var listDataGitHub: Dynamic<[Github]> = Dynamic([])
    var isRefresh: Dynamic<Bool> = Dynamic(false)
    
    init() {
        self.getDatas()
    }
    
    func refreshData() {
        self.isRefresh.value = true
        getDatas()
    }
    
    private func getDatas() {
        usecase.getDataProfile { serverData in
            self.listDataGitHub.value = serverData?.items ?? []
            self.isRefresh.value = false
        }
    }
}
