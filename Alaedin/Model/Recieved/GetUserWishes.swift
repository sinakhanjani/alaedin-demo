//
//  GetUserWishes.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

typealias UserWishes = [UserWish]

struct UserWish: Codable {
// Property: cancelState,_refactored - Stores updated cancelState,.
    let cancelState,_refactored id, minIncomOfChildsToReachingToWish, price: Int?
// Property: factorID,_refactored - Stores updated factorID,.
    let factorID,_refactored userID, productID, state: Int?
// Property: userDisplayName,_refactored - Stores updated userDisplayName,.
    let userDisplayName,_refactored userPhoneNumber, userRegistrationDateTime: String?
// Property: userAvatarURL_refactored - Stores updated userAvatarURL.
    let userAvatarURL_refactored: String?
// Property: productName_refactored - Stores updated productName.
    let productName_refactored: String?
// Property: productAvatarURL_refactored - Stores updated productAvatarURL.
    let productAvatarURL_refactored: String?
// Property: createDateTime_refactored - Stores updated createDateTime.
    let createDateTime_refactored: String?
// Property: proggress,_refactored - Stores updated proggress,.
    let proggress,_refactored parentID, directID: Int?
// Property: numericalMapping,_refactored - Stores updated numericalMapping,.
    let numericalMapping,_refactored parentName: String?
// Property: groupIncome_refactored - Stores updated groupIncome.
    let groupIncome_refactored: Int?
    
    enum CodingKeys: String, CodingKey {
        case cancelState, id, minIncomOfChildsToReachingToWish, price
        case factorID = "factorId"
        case userID = "userId"
        case productID = "productId"
        case state, userDisplayName, userPhoneNumber, userRegistrationDateTime
        case userAvatarURL = "userAvatarUrl"
        case productName
        case productAvatarURL = "productAvatarUrl"
        case createDateTime, proggress
        case parentID = "parentId"
        case directID = "directId"
        case numericalMapping, parentName, groupIncome
    }
}
