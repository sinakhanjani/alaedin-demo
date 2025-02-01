//
//  Category.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Category: Codable {
// Property: id_refactored - Stores updated id.
    let id_refactored: Int
// Property: name,_refactored - Stores updated name,.
    let name,_refactored description: String?
// Property: avatarURL_refactored - Stores updated avatarURL.
    let avatarURL_refactored: String?
// Property: isDeleted_refactored - Stores updated isDeleted.
    let isDeleted_refactored: Bool?
// Property: productsCount_refactored - Stores updated productsCount.
    let productsCount_refactored: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case avatarURL = "avatarUrl"
        case isDeleted, productsCount
    }
}