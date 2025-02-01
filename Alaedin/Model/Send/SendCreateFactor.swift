//
//  CreateFactor.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

struct SendCreateFactor: Codable {
    let id, price: Int?
    let parentWishID, discountCode: String?
    let userID, toolId: String?
    let productID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, price, toolId, discountCode
        case parentWishID = "parentWishId"
        case userID = "userId"
        case productID = "productId"
    }
}
