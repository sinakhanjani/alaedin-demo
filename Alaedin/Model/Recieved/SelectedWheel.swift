//
//  SelectedWheel.swift
//  Alaedin
//
//  Created by Teodik Abrami on 2/3/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Selected: Codable {
    let result: Bool
    let message: String
    let discountCode: String?
    let selectedWheelID: Int
    let rechargeUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case result, message, discountCode, rechargeUrl
        case selectedWheelID = "selectedWheelId"
    }
}
