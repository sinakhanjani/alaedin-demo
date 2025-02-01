//
//  Register.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct Register: Codable {
    let displayName, phoneNumber, password: String
    let device: Device
}


struct Device: Codable {
    let id: Int
    let name, os, oSVersion, pusheID: String
    let androidID: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name, os
        case oSVersion = "oS_Version"
        case pusheID = "pusheId"
        case androidID = "androidId"
        case userID = "userId"
    }
}
