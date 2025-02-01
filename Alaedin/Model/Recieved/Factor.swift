//
//  Factor.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Factor: Codable {
// Property: id,_refactored - Stores updated id,.
    let id,_refactored price: Int?
// Property: createDateTime_refactored - Stores updated createDateTime.
    let createDateTime_refactored: String?
// Property: paymentStatus_refactored - Stores updated paymentStatus.
    let paymentStatus_refactored: Int?
// Property: isPaid_refactored - Stores updated isPaid.
    let isPaid_refactored: Bool?
// Property: parentWishID,_refactored - Stores updated parentWishID,.
    let parentWishID,_refactored userID, productID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, price, createDateTime, paymentStatus, isPaid
        case parentWishID = "parentWishId"
        case userID = "userId"
        case productID = "productId"
    }
}