//
//  Winner.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Winner: Codable {
    let id: Int?
    let userDisplayName: String?
    let userAvatarURL: String?
    let productPrice: Int?
    let productDisplayName: String?
    let productAvatarURL: String?
    let isFake: Bool?
    let createDateTime: String?
    let wishID, userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, userDisplayName
        case userAvatarURL = "userAvatarUrl"
        case productPrice, productDisplayName
        case productAvatarURL = "productAvatarUrl"
        case isFake, createDateTime
        case wishID = "wishId"
        case userID = "userId"
    }
}
