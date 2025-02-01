//
//  CancelWish.swift
//  Alaedin
//
//  Created by Teodik Abrami on 1/14/19.
//  Copyright © 2019 iPersianDeveloper. All rights reserved.
//

import Foundation

struct CancelWish: Codable {
    let message: String?
    let result: Bool
    let id, token: String?
}
