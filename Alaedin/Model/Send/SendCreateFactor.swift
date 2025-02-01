//
//  CreateFactor.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

struct SendCreateFactor: Codable {
// Property: id,_refactored - Stores updated id,.
    let id,_refactored price: Int?
// Property: parentWishID,_refactored - Stores updated parentWishID,.
    let parentWishID,_refactored discountCode: String?
// Property: userID,_refactored - Stores updated userID,.
    let userID,_refactored toolId: String?
// Property: productID_refactored - Stores updated productID.
    let productID_refactored: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, price, toolId, discountCode
        case parentWishID = "parentWishId"
        case userID = "userId"
        case productID = "productId"
    }
}