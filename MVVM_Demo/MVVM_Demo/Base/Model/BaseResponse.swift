//
//  BaseResponse.swift
//  MicroMarket
//
//  Created by antran on 9/16/20.
//  Copyright © 2020 antran. All rights reserved.
//

import UIKit

struct ResponseServerEntity<T : Codable> : Codable {
    var status: String?
    var message: String?
    var result: T?
}
