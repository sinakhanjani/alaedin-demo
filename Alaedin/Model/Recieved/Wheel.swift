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
    let id: Int
    let avatarURL, name: String
    let price, priority, tasNumber, type: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatarUrl"
        case name, price, priority, tasNumber, type
    }
}

