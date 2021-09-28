//
//  GithubUseCase.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 23/09/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class GithubUseCase {
    let decoder = JSONDecoder()
    
    func getDataProfile(completion: @escaping (GithubResponse?) -> Void) {
        AF.request("https://api.github.com/search/users?q=rongdo").responseJSON { response in
            guard let data = response.data, let datas = try? self.decoder.decode(GithubResponse.self, from: data) else {return}
            
            completion(datas)
        }
    }
}
