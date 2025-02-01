//
//  Factor.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Factor: Codable {
    let id, price: Int?
    let createDateTime: String?
    let paymentStatus: Int?
    let isPaid: Bool?
    let parentWishID, userID, productID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, price, createDateTime, paymentStatus, isPaid
        case parentWishID = "parentWishId"
        case userID = "userId"
        case productID = "productId"
    }
}
