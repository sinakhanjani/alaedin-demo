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
    let cancelState, id, minIncomOfChildsToReachingToWish, price: Int?
    let factorID, userID, productID, state: Int?
    let userDisplayName, userPhoneNumber, userRegistrationDateTime: String?
    let userAvatarURL: String?
    let productName: String?
    let productAvatarURL: String?
    let createDateTime: String?
    let proggress, parentID, directID: Int?
    let numericalMapping, parentName: String?
    let groupIncome: Int?
    
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

