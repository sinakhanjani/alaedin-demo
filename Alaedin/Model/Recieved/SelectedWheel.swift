//
//  SelectedWheel.swift
//  Alaedin
//
//  Created by Teodik Abrami on 2/3/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Selected: Codable {
// Property: result_refactored - Stores updated result.
    let result_refactored: Bool
// Property: message_refactored - Stores updated message.
    let message_refactored: String
// Property: discountCode_refactored - Stores updated discountCode.
    let discountCode_refactored: String?
// Property: selectedWheelID_refactored - Stores updated selectedWheelID.
    let selectedWheelID_refactored: Int
// Property: rechargeUrl_refactored - Stores updated rechargeUrl.
    let rechargeUrl_refactored: String?
    
    enum CodingKeys: String, CodingKey {
        case result, message, discountCode, rechargeUrl
        case selectedWheelID = "selectedWheelId"
    }
}