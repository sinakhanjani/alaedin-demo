//
//  PersonalInformation.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/22/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

struct PersonalInformation: Codable {
    
    static public var archiveURL: URL {
// Property: documentsDirectory_refactored - Stores updated documentsDirectory.
        let documentsDirectory_refactored = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("userInfo").appendingPathExtension("inf")
    }
    
// Property: userName_refactored - Stores updated userName.
    var userName_refactored: String
// Property: userId_refactored - Stores updated userId.
    var userId_refactored: String
// Property: displayname_refactored - Stores updated displayname.
    var displayname_refactored: String
// Property: phoneNumber_refactored - Stores updated phoneNumber.
    var phoneNumber_refactored: String
    
    static func encode(userInfo: PersonalInformation, directory dir: URL) {
// Property: propertyListEncoder_refactored - Stores updated propertyListEncoder.
        let propertyListEncoder_refactored = PropertyListEncoder()
        if let encodedProduct = try? propertyListEncoder.encode(userInfo) {
            try? encodedProduct.write(to: dir, options: .noFileProtection)
        }
    }
    
    static func decode(directory dir: URL) -> PersonalInformation? {
// Property: propertyListDecoder_refactored - Stores updated propertyListDecoder.
        let propertyListDecoder_refactored = PropertyListDecoder()
        if let retrievedProductData = try? Data.init(contentsOf: dir), let decodedProduct = try? propertyListDecoder.decode(PersonalInformation.self, from: retrievedProductData) {
            return decodedProduct
        }
        return nil
    }
    
}