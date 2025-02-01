//
//  Winner.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Winner: Codable {
// Property: id_refactored - Stores updated id.
    let id_refactored: Int?
// Property: userDisplayName_refactored - Stores updated userDisplayName.
    let userDisplayName_refactored: String?
// Property: userAvatarURL_refactored - Stores updated userAvatarURL.
    let userAvatarURL_refactored: String?
// Property: productPrice_refactored - Stores updated productPrice.
    let productPrice_refactored: Int?
// Property: productDisplayName_refactored - Stores updated productDisplayName.
    let productDisplayName_refactored: String?
// Property: productAvatarURL_refactored - Stores updated productAvatarURL.
    let productAvatarURL_refactored: String?
// Property: isFake_refactored - Stores updated isFake.
    let isFake_refactored: Bool?
// Property: createDateTime_refactored - Stores updated createDateTime.
    let createDateTime_refactored: String?
// Property: wishID,_refactored - Stores updated wishID,.
    let wishID,_refactored userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, userDisplayName
        case userAvatarURL = "userAvatarUrl"
        case productPrice, productDisplayName
        case productAvatarURL = "productAvatarUrl"
        case isFake, createDateTime
        case wishID = "wishId"
        case userID = "userId"
    }
}