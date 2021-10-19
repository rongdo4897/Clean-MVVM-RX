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
import RxSwift

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
    func request<T: Codable>(router: RouterApi, showLoading: Bool = true, autoHide: Bool = true) ->  Observable<ResponseServerEntity<T>> {
        
        return Observable.create { observer in
            var returnEntity: ResponseServerEntity<T> = ResponseServerEntity()
            self.displayLoading(showLoading)
            
            // Kiểm tra nếu kết nối mạng bị mất
            if !Reachability.isConnectedToNetwork() {
                returnEntity.message = ResponseErrorCode.NETWORK_ERROR.message()
                returnEntity.categories = nil
                self.hideLoading(true)
                observer.onNext(returnEntity)
                observer.onCompleted()
            }
            
            let request = router.request()
            
            self.task =  URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    guard let data = data, error == nil else {
                        // Nếu có lỗi xảy ra
                        if let errors = error as? URLError {
                            returnEntity.categories = nil
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
                        observer.onNext(returnEntity)
                        observer.onCompleted()
                        return
                    }
                    self.hideLoading(autoHide)

                    if let httpStatus = response as? HTTPURLResponse {
                        if let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
                            if HTTPCode.success.contains(httpStatus.statusCode) {
                                if let model : ResponseServerEntity<T> = Parser.parser(data : data) {
                                    returnEntity = model
                                    if T.self is BaseNullModel.Type, let result = BaseNullModel() as? T {
                                        returnEntity.categories = result
                                    }
                                } else {
                                    returnEntity.message = json["message"] as? String
                                    returnEntity.categories = nil
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
                                    returnEntity.categories = nil
                                default:
                                    returnEntity.message = json["message"] as? String
                                    returnEntity.categories = nil
                                }
                            }
                        } else {
                            returnEntity.categories = nil
                            returnEntity.message = ResponseErrorCode.JSON_ERROR.message()
                        }
                        observer.onNext(returnEntity)
                        observer.onCompleted()
                    }
                } catch let error as NSError {
                    returnEntity.message = error.description
                    observer.onNext(returnEntity)
                    observer.onCompleted()
                }
            }
            
            self.task?.resume()
            
            return Disposables.create()
        }
    }
}

extension ApiManage {
//    func request<T : Codable>(router: RouterApi, showLoading: Bool = true, autoHide: Bool = true, completion: ((_ data : ResponseServerEntity<T>) -> Void)?) {
//        var returnEntity: ResponseServerEntity<T> = ResponseServerEntity()
//        self.displayLoading(showLoading)
//        if !Reachability.isConnectedToNetwork() {
//            returnEntity.message = ResponseErrorCode.NETWORK_ERROR.message()
//            returnEntity.items = nil
//            self.hideLoading(true)
//            if let block = completion {
//                block(returnEntity)
//            }
//            return
//        }
//        let request = router.request()
//        task =  URLSession.shared.dataTask(with: request) { (data, response, error) in
//            do {
//                guard let data = data, error == nil else {
//                    if let block = completion {
//                        if let errors = error as? URLError {
//                            returnEntity.items = nil
//                            switch errors.code {
//                            case .timedOut:
//                                returnEntity.message = ResponseErrorCode.TIMEOUT.message()
//                            case .notConnectedToInternet:
//                                returnEntity.message = ResponseErrorCode.NETWORK_ERROR.message()
//                            default:
//                                returnEntity.message = ResponseErrorCode.HTTP_ERROR.message()
//                            }
//                        }
//                        self.hideLoading(true)
//                        block(returnEntity)
//                    }
//                    return
//                }
//                self.hideLoading(autoHide)
//
//                if let httpStatus = response as? HTTPURLResponse {
//                    if let block = completion {
//                        if let json = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? [String: Any] {
//                            if HTTPCode.success.contains(httpStatus.statusCode) {
//                                if let model : ResponseServerEntity<T> = Parser.parser(data : data) {
//                                    returnEntity = model
//                                    if T.self is BaseNullModel.Type, let result = BaseNullModel() as? T {
//                                        returnEntity.items = result
//                                    }
//                                } else {
//                                    returnEntity.message = json["message"] as? String
//                                    returnEntity.items = nil
//                                }
//                            } else {
//                                switch httpStatus.statusCode {
//                                case HTTPCode.unauthorized:
////                                    if let statusCode = json["status"] as? String, statusCode == "119" {
////                                        self.retryRefresh(router: router, completion: block)
////                                    } else {
////                                        returnEntity.status = json["status"] as? String
////                                        returnEntity.message = json["message"] as? String
////                                        returnEntity.result = nil
////                                    }
//                                    returnEntity.items = nil
//                                default:
//                                    returnEntity.message = json["message"] as? String
//                                    returnEntity.items = nil
//                                }
//                            }
//                        } else {
//                            returnEntity.items = nil
//                            returnEntity.message = ResponseErrorCode.JSON_ERROR.message()
//                        }
//                        block(returnEntity)
//                    }
//                }
//            } catch let error as NSError {
//                returnEntity.message = error.description
//                completion?(returnEntity)
//            }
//        }
//
//        task?.resume()
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
