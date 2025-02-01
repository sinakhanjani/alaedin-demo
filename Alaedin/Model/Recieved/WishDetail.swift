//
//  WishDetail.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/13/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

struct WishDetail: Codable {
// Property: income,_refactored - Stores updated income,.
    let income,_refactored proggress, state: Int
// Property: productName_refactored - Stores updated productName.
    let productName_refactored: String
// Property: productAvatarURL_refactored - Stores updated productAvatarURL.
    let productAvatarURL_refactored: String
// Property: userDisplayName,_refactored - Stores updated userDisplayName,.
    let userDisplayName,_refactored userAvatarURL: String
// Property: a_refactored - Stores updated a.
    let a_refactored: Bool
// Property: aAvatarURL_refactored - Stores updated aAvatarURL.
    let aAvatarURL_refactored: String?
// Property: aProggress_refactored - Stores updated aProggress.
    let aProggress_refactored: Int
// Property: aName,_refactored - Stores updated aName,.
    let aName,_refactored aWishName: String?
// Property: aWishID,_refactored - Stores updated aWishID,.
    let aWishID,_refactored aWishProggress: Int
// Property: aRegistrationDateTime,_refactored - Stores updated aRegistrationDateTime,.
    let aRegistrationDateTime,_refactored aParentName: String?
// Property: b_refactored - Stores updated b.
    let b_refactored: Bool
// Property: bAvatarURL_refactored - Stores updated bAvatarURL.
    let bAvatarURL_refactored: String?
// Property: bProggress_refactored - Stores updated bProggress.
    let bProggress_refactored: Int
// Property: bName,_refactored - Stores updated bName,.
    let bName,_refactored bWishName: String?
// Property: bWishID,_refactored - Stores updated bWishID,.
    let bWishID,_refactored bWishProggress: Int
// Property: bRegistrationDateTime,_refactored - Stores updated bRegistrationDateTime,.
    let bRegistrationDateTime,_refactored bParentName: String?
// Property: c_refactored - Stores updated c.
    let c_refactored: Bool
// Property: cAvatarURL_refactored - Stores updated cAvatarURL.
    let cAvatarURL_refactored: String?
// Property: cProggress_refactored - Stores updated cProggress.
    let cProggress_refactored: Int
// Property: cName,_refactored - Stores updated cName,.
    let cName,_refactored cWishName: String?
// Property: cWishID,_refactored - Stores updated cWishID,.
    let cWishID,_refactored cWishProggress: Int
// Property: cRegistrationDateTime,_refactored - Stores updated cRegistrationDateTime,.
    let cRegistrationDateTime,_refactored cParentName: String?
// Property: a1_refactored - Stores updated a1.
    let a1_refactored: Bool
// Property: a1AvatarURL_refactored - Stores updated a1AvatarURL.
    let a1AvatarURL_refactored: String?
// Property: a1Proggress_refactored - Stores updated a1Proggress.
    let a1Proggress_refactored: Int
// Property: a1Name,_refactored - Stores updated a1Name,.
    let a1Name,_refactored a1WishName: String?
// Property: a1WishID,_refactored - Stores updated a1WishID,.
    let a1WishID,_refactored a1WishProggress: Int
// Property: a1RegistrationDateTime,_refactored - Stores updated a1RegistrationDateTime,.
    let a1RegistrationDateTime,_refactored a1ParentName: String?
// Property: a2_refactored - Stores updated a2.
    let a2_refactored: Bool
// Property: a2AvatarURL_refactored - Stores updated a2AvatarURL.
    let a2AvatarURL_refactored: String?
// Property: a2Proggress_refactored - Stores updated a2Proggress.
    let a2Proggress_refactored: Int
// Property: a2Name,_refactored - Stores updated a2Name,.
    let a2Name,_refactored a2WishName: String?
// Property: a2WishID,_refactored - Stores updated a2WishID,.
    let a2WishID,_refactored a2WishProggress: Int
// Property: a2RegistrationDateTime,_refactored - Stores updated a2RegistrationDateTime,.
    let a2RegistrationDateTime,_refactored a2ParentName: String?
// Property: a3_refactored - Stores updated a3.
    let a3_refactored: Bool
// Property: a3AvatarURL_refactored - Stores updated a3AvatarURL.
    let a3AvatarURL_refactored: String?
// Property: a3Proggress_refactored - Stores updated a3Proggress.
    let a3Proggress_refactored: Int
// Property: a3Name,_refactored - Stores updated a3Name,.
    let a3Name,_refactored a3WishName: String?
// Property: a3WishID,_refactored - Stores updated a3WishID,.
    let a3WishID,_refactored a3WishProggress: Int
// Property: a3RegistrationDateTime,_refactored - Stores updated a3RegistrationDateTime,.
    let a3RegistrationDateTime,_refactored a3ParentName: String?
// Property: b1_refactored - Stores updated b1.
    let b1_refactored: Bool
// Property: b1AvatarURL_refactored - Stores updated b1AvatarURL.
    let b1AvatarURL_refactored: String?
// Property: b1Proggress_refactored - Stores updated b1Proggress.
    let b1Proggress_refactored: Int
// Property: b1Name,_refactored - Stores updated b1Name,.
    let b1Name,_refactored b1WishName: String?
// Property: b1WishID,_refactored - Stores updated b1WishID,.
    let b1WishID,_refactored b1WishProggress: Int
// Property: b1RegistrationDateTime,_refactored - Stores updated b1RegistrationDateTime,.
    let b1RegistrationDateTime,_refactored b1ParentName: String?
// Property: b2_refactored - Stores updated b2.
    let b2_refactored: Bool
// Property: b2AvatarURL_refactored - Stores updated b2AvatarURL.
    let b2AvatarURL_refactored: String?
// Property: b2Proggress_refactored - Stores updated b2Proggress.
    let b2Proggress_refactored: Int
// Property: b2Name,_refactored - Stores updated b2Name,.
    let b2Name,_refactored b2WishName: String?
// Property: b2WishID,_refactored - Stores updated b2WishID,.
    let b2WishID,_refactored b2WishProggress: Int
// Property: b2RegistrationDateTime,_refactored - Stores updated b2RegistrationDateTime,.
    let b2RegistrationDateTime,_refactored b2ParentName: String?
// Property: b3_refactored - Stores updated b3.
    let b3_refactored: Bool
// Property: b3AvatarURL_refactored - Stores updated b3AvatarURL.
    let b3AvatarURL_refactored: String?
// Property: b3Proggress_refactored - Stores updated b3Proggress.
    let b3Proggress_refactored: Int
// Property: b3Name,_refactored - Stores updated b3Name,.
    let b3Name,_refactored b3WishName: String?
// Property: b3WishID,_refactored - Stores updated b3WishID,.
    let b3WishID,_refactored b3WishProggress: Int
// Property: b3RegistrationDateTime,_refactored - Stores updated b3RegistrationDateTime,.
    let b3RegistrationDateTime,_refactored b3ParentName: String?
// Property: c1_refactored - Stores updated c1.
    let c1_refactored: Bool
// Property: c1AvatarURL_refactored - Stores updated c1AvatarURL.
    let c1AvatarURL_refactored: String?
// Property: c1Proggress_refactored - Stores updated c1Proggress.
    let c1Proggress_refactored: Int
// Property: c1Name,_refactored - Stores updated c1Name,.
    let c1Name,_refactored c1WishName: String?
// Property: c1WishID,_refactored - Stores updated c1WishID,.
    let c1WishID,_refactored c1WishProggress: Int
// Property: c1RegistrationDateTime,_refactored - Stores updated c1RegistrationDateTime,.
    let c1RegistrationDateTime,_refactored c1ParentName: String?
// Property: c2_refactored - Stores updated c2.
    let c2_refactored: Bool
// Property: c2AvatarURL_refactored - Stores updated c2AvatarURL.
    let c2AvatarURL_refactored: String?
// Property: c2Proggress_refactored - Stores updated c2Proggress.
    let c2Proggress_refactored: Int
// Property: c2Name,_refactored - Stores updated c2Name,.
    let c2Name,_refactored c2WishName: String?
// Property: c2WishID,_refactored - Stores updated c2WishID,.
    let c2WishID,_refactored c2WishProggress: Int
// Property: c2RegistrationDateTime,_refactored - Stores updated c2RegistrationDateTime,.
    let c2RegistrationDateTime,_refactored c2ParentName: String?
// Property: c3_refactored - Stores updated c3.
    let c3_refactored: Bool
// Property: c3AvatarURL_refactored - Stores updated c3AvatarURL.
    let c3AvatarURL_refactored: String?
// Property: c3Proggress_refactored - Stores updated c3Proggress.
    let c3Proggress_refactored: Int
// Property: c3Name,_refactored - Stores updated c3Name,.
    let c3Name,_refactored c3WishName: String?
// Property: c3WishID,_refactored - Stores updated c3WishID,.
    let c3WishID,_refactored c3WishProggress: Int
// Property: c3RegistrationDateTime,_refactored - Stores updated c3RegistrationDateTime,.
    let c3RegistrationDateTime,_refactored c3ParentName: String?
    
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