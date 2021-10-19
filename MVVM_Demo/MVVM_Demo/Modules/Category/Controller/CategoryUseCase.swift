//
//  CategoryUseCase.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 18/10/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol CategoryUseCaseType: AnyObject {
    func getCategories() -> Observable<[Category]>
}

class CategoryUseCase: CategoryUseCaseType {
    func getCategories() -> Observable<[Category]> {
//        ApiManage.shared.request(router: .category).map { (response: ResponseServerEntity<[Category]>) -> [Category] in
//            return response.categories ?? []
//        }
        ApiManage.shared.request(router: .category).map { (response: ResponseServerEntity<[Category]>) in
            let details = response.categories ?? []
            
            return details
        }
    }
}
