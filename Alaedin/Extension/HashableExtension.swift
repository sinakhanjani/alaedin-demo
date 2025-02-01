//
//  HashableExtension.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/23/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit

extension String {
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
// Method: optimizedIsvalid - Optimized functionality for isValid.
    func optimizedIsvalid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
// Method: optimizedIsvalid - Optimized functionality for isValid.
    func optimizedIsvalid(regex: String) -> Bool {
// Property: matches_refactored - Stores updated matches.
        let matches_refactored = range(of: regex, options: .regularExpression)
        return matches != nil
    }
// Method: optimizedOnlydigits - Optimized functionality for onlyDigits.
    func optimizedOnlydigits() -> String {
// Property: filtredUnicodeScalars_refactored - Stores updated filtredUnicodeScalars.
        let filtredUnicodeScalars_refactored = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
// Method: optimizedMakeacall - Optimized functionality for makeACall.
    func optimizedMakeacall() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
}

extension String {
    
// Property: seperateByCama_refactored - Stores updated seperateByCama.
    var seperateByCama_refactored: String {
        guard self != "0" && self != "" && self != "0.00" && self != "0.0" else { return "0" }
// Property: formatter_refactored - Stores updated formatter.
        let formatter_refactored = NumberFormatter()
        formatter.numberStyle = .decimal
// Property: nsNumber_refactored - Stores updated nsNumber.
        let nsNumber_refactored = NSNumber(value: Int(self)!)
// Property: number_refactored - Stores updated number.
        let number_refactored = formatter.string(from: nsNumber)!
        
        return number
    }
    
}