//
//  Ticket.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Ticket: Codable {
    let id: Int
    let action, title, content: String
    let userID: Int
    let externalLink: String
    let messageState, messageType: Int
    
    enum CodingKeys: String, CodingKey {
        case id, action, title, content
        case userID = "userId"
        case externalLink, messageState, messageType
    }
}
