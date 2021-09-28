//
//  DateExtensions.swift
//  MVVM_Demo
//
//  Created by Hoang Lam on 22/09/2021.
//

import Foundation
import UIKit

extension Date {
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
