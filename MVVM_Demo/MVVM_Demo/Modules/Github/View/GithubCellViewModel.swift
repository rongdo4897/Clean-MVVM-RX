//
//  GithubCellViewModel.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import Foundation
import Alamofire

class GitHubCellViewModel {
    var imageUrl: String
    var name: String
    var type: String
    var score: String
    
    init(github: Github) {
        self.imageUrl = github.avatar_url ?? ""
        self.name = github.login ?? ""
        self.type = github.type ?? ""
        self.score = String(github.score ?? 0.0)
    }
}
