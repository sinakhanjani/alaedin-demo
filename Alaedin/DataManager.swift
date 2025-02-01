//
//  DataManager.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    var openViews = 1
    
    public var stopSound: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "IS_PLAY_SOUND")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "IS_PLAY_SOUND")
        }
    }
    
    public var userInformation: PersonalInformation? {
        get {
            return PersonalInformation.decode(directory: PersonalInformation.archiveURL)
        }
        set {
            if let encode = newValue {
                PersonalInformation.encode(userInfo: encode, directory: PersonalInformation.archiveURL)
            }
        }
    }
    
    public var stopIntro: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "IS_PLAY_INTRO")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "IS_PLAY_INTRO")
        }
    }
    
    public var firstTimeRulesAndPolicy: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "FIRST_TIME_RULES_AND_POLICY")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "FIRST_TIME_RULES_AND_POLICY")
        }
    }
    
//    public var playVideo1: Bool {
//        get {
//            return UserDefaults.standard.bool(forKey: "PLAYVIDEO1")
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "PLAYVIDEO1")
//        }
//    }
//
//    public var playVideo2: Bool {
//        get {
//            return UserDefaults.standard.bool(forKey: "PLAYVIDEO2")
//        }
//        set {
//            UserDefaults.standard.set(newValue, forKey: "PLAYVIDEO2")
//        }
//    }
    
    public var playVideo3: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "PLAYVIDEO3")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "PLAYVIDEO3")
        }
    }
    
    public var winnerVideoKeys: [String] {
        get {
           return UserDefaults.standard.array(forKey: "videoKeys") as? [String] ?? [String]()
        }
        set {
            randomNo += 1
            UserDefaults.standard.set(newValue, forKey: "videoKeys")
        }
    }
    
    public var randomNo: Int {
        get {
            return UserDefaults.standard.integer(forKey: "randomNo")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "randomNo")
        }
    }
    
    public var welcomeInApp: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "welcomeInapp")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "welcomeInapp")
        }
    }
    
    
}
