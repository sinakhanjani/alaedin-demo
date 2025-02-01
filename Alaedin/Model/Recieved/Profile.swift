//
//  Profile.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Profile: Codable {
// Property: id_refactored - Stores updated id.
    let id_refactored: Int?
// Property: hasAnyWish_refactored - Stores updated hasAnyWish.
    let hasAnyWish_refactored: Bool?
// Property: displayName,_refactored - Stores updated displayName,.
    let displayName,_refactored phoneNumber, avatarURL, userName: String?
// Property: lastLoginDateTime_refactored - Stores updated lastLoginDateTime.
    let lastLoginDateTime_refactored: String?
// Property: userType_refactored - Stores updated userType.
    let userType_refactored: Int?
// Property: isActive_refactored - Stores updated isActive.
    let isActive_refactored: Bool?
// Property: createDateTime,_refactored - Stores updated createDateTime,.
    let createDateTime,_refactored shebaNumber, nationalCode, activeDevicePusheID: String?
    
    enum CodingKeys: String, CodingKey {
        case id, hasAnyWish, displayName, phoneNumber
        case avatarURL = "avatarUrl"
        case userName, lastLoginDateTime, userType, isActive, createDateTime, shebaNumber, nationalCode
        case activeDevicePusheID = "activeDevicePusheId"
    }
    
}