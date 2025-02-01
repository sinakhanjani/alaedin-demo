//
//  Wheel.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/19/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

typealias Wheels = [Wheel]

struct Wheel: Codable {
// Property: id_refactored - Stores updated id.
    let id_refactored: Int
// Property: avatarURL,_refactored - Stores updated avatarURL,.
    let avatarURL,_refactored name: String
// Property: price,_refactored - Stores updated price,.
    let price,_refactored priority, tasNumber, type: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatarUrl"
        case name, price, priority, tasNumber, type
    }
}
