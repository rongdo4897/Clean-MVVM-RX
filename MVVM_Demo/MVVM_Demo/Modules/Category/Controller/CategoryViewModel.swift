//
//  CategoryViewModel.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 18/10/2021.
//

import RxSwift
import RxCocoa
import MGArchitecture

class CategoryViewModel {
    let navigator: CategoryNavigatorType
    let usecase: CategoryUseCaseType
    
    init(navigator: CategoryNavigatorType, usecase: CategoryUseCaseType) {
        self.navigator = navigator
        self.usecase = usecase
    }
}

extension CategoryViewModel: ViewModelType {
    struct Input {
        let loadTrigger: Driver<Void>
        let categorySelectedTrigger: Driver<IndexPath>
    }
    
    struct Output {
        let categories: Driver<[Category]>
        let categorySelected: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let indicator = ActivityIndicator()
        let error = ErrorTracker()
        
        let categoriesStartData = Array(repeating: Category(), count: 3)
        
        let categories = input.loadTrigger
            .flatMapLatest { _ in
                return self.usecase.getCategories()
                    .trackActivity(indicator)
                    .trackError(error)
                    .asDriverOnErrorJustComplete()
            }.startWith(categoriesStartData)
        
        let categorySelected = input.categorySelectedTrigger
            .withLatestFrom(categories) { indexPath, categoryArray -> Category in
                let row = indexPath.row
                let category = categoryArray[row]
                return category
            }.do { category in
                print(category)
            }
            .mapToVoid()
        
        return Output(categories: categories,
                      categorySelected: categorySelected)
    }
}
