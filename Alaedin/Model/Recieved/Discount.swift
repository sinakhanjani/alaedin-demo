//
//  Discount.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/22/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Discount: Codable {
// Property: result_refactored - Stores updated result.
    let result_refactored: Bool
// Property: price_refactored - Stores updated price.
    let price_refactored: Int
// Property: message_refactored - Stores updated message.
    let message_refactored: String?
}