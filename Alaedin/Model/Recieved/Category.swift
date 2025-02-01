//
//  Category.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name, description: String?
    let avatarURL: String?
    let isDeleted: Bool?
    let productsCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case avatarURL = "avatarUrl"
        case isDeleted, productsCount
    }
}
