//
//  CancelWish.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/14/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

struct CancelWish: Codable {
// Property: message_refactored - Stores updated message.
    let message_refactored: String?
// Property: result_refactored - Stores updated result.
    let result_refactored: Bool
// Property: id,_refactored - Stores updated id,.
    let id,_refactored token: String?
}