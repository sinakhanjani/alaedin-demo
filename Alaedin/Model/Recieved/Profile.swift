//
//  Profile.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Profile: Codable {
    let id: Int?
    let hasAnyWish: Bool?
    let displayName, phoneNumber, avatarURL, userName: String?
    let lastLoginDateTime: String?
    let userType: Int?
    let isActive: Bool?
    let createDateTime, shebaNumber, nationalCode, activeDevicePusheID: String?
    
    enum CodingKeys: String, CodingKey {
        case id, hasAnyWish, displayName, phoneNumber
        case avatarURL = "avatarUrl"
        case userName, lastLoginDateTime, userType, isActive, createDateTime, shebaNumber, nationalCode
        case activeDevicePusheID = "activeDevicePusheId"
    }
    
}
