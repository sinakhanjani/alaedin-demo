//
//  Register.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Register: Codable {
// Property: displayName,_refactored - Stores updated displayName,.
    let displayName,_refactored phoneNumber, password: String
// Property: device_refactored - Stores updated device.
    let device_refactored: Device
}


struct Device: Codable {
// Property: id_refactored - Stores updated id.
    let id_refactored: Int
// Property: name,_refactored - Stores updated name,.
    let name,_refactored os, oSVersion, pusheID: String
// Property: androidID_refactored - Stores updated androidID.
    let androidID_refactored: String
// Property: userID_refactored - Stores updated userID.
    let userID_refactored: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, os
        case oSVersion = "oS_Version"
        case pusheID = "pusheId"
        case androidID = "androidId"
        case userID = "userId"
    }
}