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

extension TimeZone {

    func timeZoneOffsetInHours() -> Int {
        let seconds = secondsFromGMT()
        let hours = seconds/3600
        return hours
    }
    func timeZoneOffsetInMinutes() -> Int {
        let seconds = secondsFromGMT()
        let minutes = abs(seconds / 60)
        return minutes
    }
}
