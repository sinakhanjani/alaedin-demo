//
//  Message.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Message: Codable {
    let id: Int?
    let title, content: String?
    let userID: Int?
    let userDisplayName: String?
    let externalLink: String?
    let createDataTime, messageState, messageType: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, content
        case userID = "userId"
        case userDisplayName, externalLink, createDataTime, messageState, messageType
    }
}
