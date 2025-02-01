//
//  Product.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Product: Codable {
    let id: Int
    let name: String
    let price, priceToWish, discount: Int?
    let isActive: Bool?
    let description, avatarURL, categoryName: String?
    let categoryID, wishesCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, priceToWish, discount, isActive, description
        case avatarURL = "avatarUrl"
        case categoryName
        case categoryID = "categoryId"
        case wishesCount
    }
}
