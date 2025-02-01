//
//  Authorization.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

class Authorization {
    
    static let shared = Authorization()
    
    private let defaults = UserDefaults.standard

    
    private var _isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: "IS_LOGGED_IN_KEY")
        }
        set {
            defaults.set(newValue, forKey: "IS_LOGGED_IN_KEY")
        }
    }
    
    private var _token: String {
        get {
            return defaults.value(forKey: "TOKEN_KEY") as? String ?? ""
        }
        set {
            defaults.set(newValue, forKey: "TOKEN_KEY")
        }
    }
    
    public var isLoggedIn: Bool {
        return _isLoggedIn
    }
    
    public var token: String {
        return _token
    }
    
    public func authenticationUser(token: String, isLoggedIn: Bool) {
        self._token = token
        self._isLoggedIn = isLoggedIn
    }
    
    public func logOutAuth() {
        self._isLoggedIn = false
        self._token = ""
        DataManager.shared.stopSound = false
        DataManager.shared.stopIntro = false
//        DataManager.shared.playVideo1 = false
//        DataManager.shared.playVideo2 = false
        DataManager.shared.playVideo3 = false
        DataManager.shared.winnerVideoKeys = [String]()
        WebServices.instance.logoutPushIdSend()
    }
    
    
}
