//
//  Github.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import Foundation

struct GithubResponse: Codable {
    var total_count: Int
    var incomplete_results: Bool
    var items: [Github]
}

struct Github: Codable {
    var login: String?
    var avatar_url: String?
    var type: String?
    var score: Double?
}
