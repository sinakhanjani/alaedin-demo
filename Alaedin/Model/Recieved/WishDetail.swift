//
//  WishDetail.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

struct WishDetail: Codable {
    let income, proggress, state: Int
    let productName: String
    let productAvatarURL: String
    let userDisplayName, userAvatarURL: String
    let a: Bool
    let aAvatarURL: String?
    let aProggress: Int
    let aName, aWishName: String?
    let aWishID, aWishProggress: Int
    let aRegistrationDateTime, aParentName: String?
    let b: Bool
    let bAvatarURL: String?
    let bProggress: Int
    let bName, bWishName: String?
    let bWishID, bWishProggress: Int
    let bRegistrationDateTime, bParentName: String?
    let c: Bool
    let cAvatarURL: String?
    let cProggress: Int
    let cName, cWishName: String?
    let cWishID, cWishProggress: Int
    let cRegistrationDateTime, cParentName: String?
    let a1: Bool
    let a1AvatarURL: String?
    let a1Proggress: Int
    let a1Name, a1WishName: String?
    let a1WishID, a1WishProggress: Int
    let a1RegistrationDateTime, a1ParentName: String?
    let a2: Bool
    let a2AvatarURL: String?
    let a2Proggress: Int
    let a2Name, a2WishName: String?
    let a2WishID, a2WishProggress: Int
    let a2RegistrationDateTime, a2ParentName: String?
    let a3: Bool
    let a3AvatarURL: String?
    let a3Proggress: Int
    let a3Name, a3WishName: String?
    let a3WishID, a3WishProggress: Int
    let a3RegistrationDateTime, a3ParentName: String?
    let b1: Bool
    let b1AvatarURL: String?
    let b1Proggress: Int
    let b1Name, b1WishName: String?
    let b1WishID, b1WishProggress: Int
    let b1RegistrationDateTime, b1ParentName: String?
    let b2: Bool
    let b2AvatarURL: String?
    let b2Proggress: Int
    let b2Name, b2WishName: String?
    let b2WishID, b2WishProggress: Int
    let b2RegistrationDateTime, b2ParentName: String?
    let b3: Bool
    let b3AvatarURL: String?
    let b3Proggress: Int
    let b3Name, b3WishName: String?
    let b3WishID, b3WishProggress: Int
    let b3RegistrationDateTime, b3ParentName: String?
    let c1: Bool
    let c1AvatarURL: String?
    let c1Proggress: Int
    let c1Name, c1WishName: String?
    let c1WishID, c1WishProggress: Int
    let c1RegistrationDateTime, c1ParentName: String?
    let c2: Bool
    let c2AvatarURL: String?
    let c2Proggress: Int
    let c2Name, c2WishName: String?
    let c2WishID, c2WishProggress: Int
    let c2RegistrationDateTime, c2ParentName: String?
    let c3: Bool
    let c3AvatarURL: String?
    let c3Proggress: Int
    let c3Name, c3WishName: String?
    let c3WishID, c3WishProggress: Int
    let c3RegistrationDateTime, c3ParentName: String?
    
    enum CodingKeys: String, CodingKey {
        case income, proggress, state, productName
        case productAvatarURL = "productAvatarUrl"
        case userDisplayName
        case userAvatarURL = "userAvatarUrl"
        case a
        case aAvatarURL = "a_AvatarUrl"
        case aProggress = "a_Proggress"
        case aName = "a_Name"
        case aWishName = "a_WishName"
        case aWishID = "a_WishId"
        case aWishProggress = "a_WishProggress"
        case aRegistrationDateTime = "a_RegistrationDateTime"
        case aParentName = "a_ParentName"
        case b
        case bAvatarURL = "b_AvatarUrl"
        case bProggress = "b_Proggress"
        case bName = "b_Name"
        case bWishName = "b_WishName"
        case bWishID = "b_WishId"
        case bWishProggress = "b_WishProggress"
        case bRegistrationDateTime = "b_RegistrationDateTime"
        case bParentName = "b_ParentName"
        case c
        case cAvatarURL = "c_AvatarUrl"
        case cProggress = "c_Proggress"
        case cName = "c_Name"
        case cWishName = "c_WishName"
        case cWishID = "c_WishId"
        case cWishProggress = "c_WishProggress"
        case cRegistrationDateTime = "c_RegistrationDateTime"
        case cParentName = "c_ParentName"
        case a1
        case a1AvatarURL = "a1_AvatarUrl"
        case a1Proggress = "a1_Proggress"
        case a1Name = "a1_Name"
        case a1WishName = "a1_WishName"
        case a1WishID = "a1_WishId"
        case a1WishProggress = "a1_WishProggress"
        case a1RegistrationDateTime = "a1_RegistrationDateTime"
        case a1ParentName = "a1_ParentName"
        case a2
        case a2AvatarURL = "a2_AvatarUrl"
        case a2Proggress = "a2_Proggress"
        case a2Name = "a2_Name"
        case a2WishName = "a2_WishName"
        case a2WishID = "a2_WishId"
        case a2WishProggress = "a2_WishProggress"
        case a2RegistrationDateTime = "a2_RegistrationDateTime"
        case a2ParentName = "a2_ParentName"
        case a3
        case a3AvatarURL = "a3_AvatarUrl"
        case a3Proggress = "a3_Proggress"
        case a3Name = "a3_Name"
        case a3WishName = "a3_WishName"
        case a3WishID = "a3_WishId"
        case a3WishProggress = "a3_WishProggress"
        case a3RegistrationDateTime = "a3_RegistrationDateTime"
        case a3ParentName = "a3_ParentName"
        case b1
        case b1AvatarURL = "b1_AvatarUrl"
        case b1Proggress = "b1_Proggress"
        case b1Name = "b1_Name"
        case b1WishName = "b1_WishName"
        case b1WishID = "b1_WishId"
        case b1WishProggress = "b1_WishProggress"
        case b1RegistrationDateTime = "b1_RegistrationDateTime"
        case b1ParentName = "b1_ParentName"
        case b2
        case b2AvatarURL = "b2_AvatarUrl"
        case b2Proggress = "b2_Proggress"
        case b2Name = "b2_Name"
        case b2WishName = "b2_WishName"
        case b2WishID = "b2_WishId"
        case b2WishProggress = "b2_WishProggress"
        case b2RegistrationDateTime = "b2_RegistrationDateTime"
        case b2ParentName = "b2_ParentName"
        case b3
        case b3AvatarURL = "b3_AvatarUrl"
        case b3Proggress = "b3_Proggress"
        case b3Name = "b3_Name"
        case b3WishName = "b3_WishName"
        case b3WishID = "b3_WishId"
        case b3WishProggress = "b3_WishProggress"
        case b3RegistrationDateTime = "b3_RegistrationDateTime"
        case b3ParentName = "b3_ParentName"
        case c1
        case c1AvatarURL = "c1_AvatarUrl"
        case c1Proggress = "c1_Proggress"
        case c1Name = "c1_Name"
        case c1WishName = "c1_WishName"
        case c1WishID = "c1_WishId"
        case c1WishProggress = "c1_WishProggress"
        case c1RegistrationDateTime = "c1_RegistrationDateTime"
        case c1ParentName = "c1_ParentName"
        case c2
        case c2AvatarURL = "c2_AvatarUrl"
        case c2Proggress = "c2_Proggress"
        case c2Name = "c2_Name"
        case c2WishName = "c2_WishName"
        case c2WishID = "c2_WishId"
        case c2WishProggress = "c2_WishProggress"
        case c2RegistrationDateTime = "c2_RegistrationDateTime"
        case c2ParentName = "c2_ParentName"
        case c3
        case c3AvatarURL = "c3_AvatarUrl"
        case c3Proggress = "c3_Proggress"
        case c3Name = "c3_Name"
        case c3WishName = "c3_WishName"
        case c3WishID = "c3_WishId"
        case c3WishProggress = "c3_WishProggress"
        case c3RegistrationDateTime = "c3_RegistrationDateTime"
        case c3ParentName = "c3_ParentName"
    }
}
