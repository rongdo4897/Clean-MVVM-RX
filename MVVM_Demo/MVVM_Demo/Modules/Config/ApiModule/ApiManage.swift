//
//  ApiManage.swift
//  FFAdmin
//
//  Created by an.trantuan on 10/7/19.
//  Copyright © 2019 an.trantuan. All rights reserved.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import Reachability

enum HTTPMethod: String {
    case options = "OPTIONS"
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case trace = "TRACE"
    case connect = "CONNECT"
}
class ApiManage: NSObject {
    static let shared: ApiManage = ApiManage()
    var task : URLSessionTask?
}

extension ApiManage {
    func request<T : Codable>(router: RouterApi, showLoading: Bool = true, autoHide: Bool = true, completion: ((_ data : ResponseServerEntity<T>) -> Void)?) {
        var returnEntity: ResponseServerEntity<T> = ResponseServerEntity()
        self.displayLoading(showLoading)
        if !Reachability.isConnectedToNetwork() {
            returnEntity.message = ResponseErrorCode.NETWORK_ERROR.message()
            returnEntity.result = nil
            self.hideLoading(true)
            if let block = completion {
                block(returnEntity)
            }
            return
        }
        let request = router.request()
        task =  URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data, error == nil else {
                    if let block = completion {
                        if let errors = error as? URLError {
                            returnEntity.result = nil
                            switch errors.code {
                            case .timedOut:
                                returnEntity.message = ResponseErrorCode.TIMEOUT.message()
                            case .notConnectedToInternet:
                                returnEntity.message = ResponseErrorCode.NETWORK_ERROR.message()
                            default:
                                returnEntity.message = ResponseErrorCode.HTTP_ERROR.message()
                            }
                        }
                        self.hideLoading(true)
                        block(returnEntity)
                    }
                    return
                }
                self.hideLoading(autoHide)

                if let httpStatus = response as? HTTPURLResponse {
                    if let block = completion {
                        if let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
                            if HTTPCode.success.contains(httpStatus.statusCode) {
                                if let model : ResponseServerEntity<T> = Parser.parser(data : data) {
                                    returnEntity = model
                                    if T.self is BaseNullModel.Type, let result = BaseNullModel() as? T {
                                        returnEntity.result = result
                                    }
                                } else {
                                    returnEntity.message = json["message"] as? String
                                    returnEntity.result = nil
                                }
                            } else {
                                switch httpStatus.statusCode {
                                case HTTPCode.unauthorized:
//                                    if let statusCode = json["status"] as? String, statusCode == "119" {
//                                        self.retryRefresh(router: router, completion: block)
//                                    } else {
//                                        returnEntity.status = json["status"] as? String
//                                        returnEntity.message = json["message"] as? String
//                                        returnEntity.result = nil
//                                    }
                                    returnEntity.result = nil
                                default:
                                    returnEntity.message = json["message"] as? String
                                    returnEntity.result = nil
                                }
                            }
                        } else {
                            returnEntity.result = nil
                            returnEntity.message = ResponseErrorCode.JSON_ERROR.message()
                        }
                        block(returnEntity)
                    }
                }
            } catch let error as NSError {
                returnEntity.message = error.description
                completion?(returnEntity)
            }
        }

        task?.resume()
    }

//    private func retryRefresh<T : Codable>(router : RouterApi, completion:  ((_ data : ResponseServerEntity<T>) -> Void)?) {
//        self.request(router: .refreshToken(RefreshTokenModel(refreshToken: LocalResourceRepository.getRefreshToken(), deviceToken: LocalResourceRepository.getDeviceToken()))) {[weak self] (data: ResponseServerEntity<LoginModel>)  in
//            if let self = self, let data = data.result {
//                LocalResourceRepository.setToken(result: data)
//                self.request(router: router) { (data: ResponseServerEntity<T>) in
//                    guard let completion = completion else {return}
//                    completion(data)
//                }
//            } else {
//                self?.task?.cancel()
//                self?.task = nil
//                AppRouter.setRootView()
//            }
//
//        }
//    }

    private func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: [])
        } catch let myJSONError {
            debugPrint("convert to json error: \(myJSONError)")
        }
        return nil
    }

    func displayLoading(_ allow: Bool) {
        if allow {
            DispatchQueue.main.async {
                if let view = UIApplication.shared.keyWindow {
                    MBProgressHUD.showAdded(to: view, animated: true)
                }
            }
        }
    }

    func hideLoading(_ allow: Bool) {
        if allow {
            DispatchQueue.main.async {
                if let view = UIApplication.shared.keyWindow {
                    MBProgressHUD.hide(for: view, animated: true)
                }
            }
        }
    }
}
extension ApiManage {
}

extension ApiManage {
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
