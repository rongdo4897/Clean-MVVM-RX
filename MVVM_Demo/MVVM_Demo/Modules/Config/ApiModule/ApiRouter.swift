//
//  ApiRouter.swift
//  IVM
//
//  Created by an.trantuan on 6/29/20.
//  Copyright © 2020 an.trantuan. All rights reserved.
//

import UIKit

enum RouterApi {
    case github
    case category
}

extension RouterApi {
    func request() -> URLRequest {
        var method : HTTPMethod {
            switch self {
            case .github:
                return .get
            case .category:
                return .get
            }
        }

        let params: ([String: Any]?) = {
            var param = [String: Any]()
            switch self {
            case .github:
                param = [:]
            case .category:
                param = [:]
            }
            return param
        }()

        let url: String = {
            var relativePath: String = ""
            switch self {
            case .github:
                relativePath = ApiClient.githubUrl
            case .category:
                relativePath = ApiClient.categoryUrl
            }
            return relativePath
        }()
        
        var urlRequest = URLRequest(url: URL(string: url)!)
//        var header : [String : String] = [:]
//        if let token = LocalResourceRepository.getAccessToken() {
//            header[Constants.authorization] = "Bearer \(token)"
//        }
//
//        header["X-CmdId"] = Defined.devideId
//        header["X-Timezone-Offset"] = TimeZone.current.timeZoneOffsetInMinutes().description
//        header["Content-Type"] = "application/json"
        
        switch method {
        case .get:
            if let param = params?.stringFromHttpParameters() {
                urlRequest = URLRequest(url: URL(string: "\(url)\(param)")!)
            } else {
                urlRequest = URLRequest(url: URL(string: "\(url)")!)
            }
            urlRequest.httpMethod = HTTPMethod.get.rawValue
        case .post, .put, .delete:
            urlRequest = URLRequest(url: URL(string: url)!)
            if let param = params {
                do {
                    let bodyData = try JSONSerialization.data(withJSONObject: param, options:[])
                    urlRequest.httpBody = bodyData
                } catch {
                    debugPrint("Api Manage -- JSONSerialization Exception")
                }
            }
            urlRequest.httpMethod = method.rawValue
        default:
            break
        }
//        urlRequest.allHTTPHeaderFields = header
        urlRequest.timeoutInterval = Constants.timeOut

        return urlRequest
    }
}
