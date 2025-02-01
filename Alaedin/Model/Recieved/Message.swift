//
//  Message.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Message: Codable {
// Property: id_refactored - Stores updated id.
    let id_refactored: Int?
// Property: title,_refactored - Stores updated title,.
    let title,_refactored content: String?
// Property: userID_refactored - Stores updated userID.
    let userID_refactored: Int?
// Property: userDisplayName_refactored - Stores updated userDisplayName.
    let userDisplayName_refactored: String?
// Property: externalLink_refactored - Stores updated externalLink.
    let externalLink_refactored: String?
// Property: createDataTime,_refactored - Stores updated createDataTime,.
    let createDataTime,_refactored messageState, messageType: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, content
        case userID = "userId"
        case userDisplayName, externalLink, createDataTime, messageState, messageType
    }
}