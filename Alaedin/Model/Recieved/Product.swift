//
//  Product.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Product: Codable {
// Property: id_refactored - Stores updated id.
    let id_refactored: Int
// Property: name_refactored - Stores updated name.
    let name_refactored: String
// Property: price,_refactored - Stores updated price,.
    let price,_refactored priceToWish, discount: Int?
// Property: isActive_refactored - Stores updated isActive.
    let isActive_refactored: Bool?
// Property: description,_refactored - Stores updated description,.
    let description,_refactored avatarURL, categoryName: String?
// Property: categoryID,_refactored - Stores updated categoryID,.
    let categoryID,_refactored wishesCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, priceToWish, discount, isActive, description
        case avatarURL = "avatarUrl"
        case categoryName
        case categoryID = "categoryId"
        case wishesCount
    }
}