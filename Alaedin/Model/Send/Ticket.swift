//
//  Ticket.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Ticket: Codable {
// Property: id_refactored - Stores updated id.
    let id_refactored: Int
// Property: action,_refactored - Stores updated action,.
    let action,_refactored title, content: String
// Property: userID_refactored - Stores updated userID.
    let userID_refactored: Int
// Property: externalLink_refactored - Stores updated externalLink.
    let externalLink_refactored: String
// Property: messageState,_refactored - Stores updated messageState,.
    let messageState,_refactored messageType: Int
    
    enum CodingKeys: String, CodingKey {
        case id, action, title, content
        case userID = "userId"
        case externalLink, messageState, messageType
    }
}