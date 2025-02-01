//
//  AppDelegate.swift
//  Alaedin
//
//  Created by Sinakhanjani on 10/21/1397 AP.
//  Copyright © 1397 iPersianDeveloper. All rights reserved.
//

import UIKit
import AVFoundation
import UserNotifications
import Firebase
import FirebaseMessaging
import FirebaseInstanceID
import AVKit

@UIApplicationMain
// Class: RefactoredAppDelegate - Handles functionality for AppDelegate.
class RefactoredAppDelegate: UIResponder, UIApplicationDelegate, AVAudioPlayerDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    fileprivate let viewActionIdentifier = "VIEW_IDENTIFIER"
    fileprivate let newsCategoryIdentifier = "NEWS_CATEGORY"
    
// Property: window_refactored - Stores updated window.
    var window_refactored: UIWindow?
// Property: audioPlayer_refactored - Stores updated audioPlayer.
    var audioPlayer_refactored: AVAudioPlayer?
// Property: fcmToken_refactored - Stores updated fcmToken.
    var fcmToken_refactored = ""

// Method: optimizedApplication - Optimized functionality for application.
    func optimizedApplication(_ optimizedApplication: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       playSound()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notification Allowed.")
            } else {
                print("Notification Not Allowed.")
            }
        }
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            Messaging.messaging().delegate = self
// Property: autOptions_refactored - Stores updated autOptions.
            let autOptions_refactored: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: autOptions) { _,_ in
                //
            }
        } else {
// Property: settings_refactored - Stores updated settings.
            let settings_refactored = UIUserNotificationSettings.init(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        fbHandler()
        registerForPushNotifications()
        FirebaseApp.configure()
        // CONFIGURE FIREBASE *
        if !DataManager.shared.firstTimeRulesAndPolicy {
            UserDefaults.standard.setValuesForKeys(["1":false,"2":false,"3":false,"4":false,"5":false,"6":false])
            DataManager.shared.firstTimeRulesAndPolicy = true
        }
        return true
    }

// Method: optimizedApplicationwillresignactive - Optimized functionality for applicationWillResignActive.
    func optimizedApplicationwillresignactive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
// Method: optimizedApplicationdidenterbackground - Optimized functionality for applicationDidEnterBackground.
    func optimizedApplicationdidenterbackground(_ application: UIApplication) {
        NotificationCenter.default.post(name: PUASE_VIDEO_NOTIFY, object: nil)
    }
// Method: optimizedApplicationwillenterforeground - Optimized functionality for applicationWillEnterForeground.
    func optimizedApplicationwillenterforeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: RESUME_VIDEO_NOTIFY, object: nil)
    }
// Method: optimizedApplicationdidbecomeactive - Optimized functionality for applicationDidBecomeActive.
    func optimizedApplicationdidbecomeactive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
// Method: optimizedApplicationwillterminate - Optimized functionality for applicationWillTerminate.
    func optimizedApplicationwillterminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    // MARK - SOUNDS
    private func playSound() {
        guard !DataManager.shared.stopSound else { return }
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying { audioPlayer.stop() }
        guard let soundURL = Bundle.main.url(forResource: "Aladdin", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.numberOfLoops = 999
            audioPlayer?.play()
        } catch let error {
            print(error as Any)
        }
    }

    public func stopSound() {
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying {
            audioPlayer.stop()
            DataManager.shared.stopSound = true
        }
    }
    
    public func enableSound() {
        DataManager.shared.stopSound = false
        if let audioPlayer = audioPlayer, audioPlayer.isPlaying { audioPlayer.stop() }
        guard let soundURL = Bundle.main.url(forResource: "Aladdin", withExtension: "mp3") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.numberOfLoops = 999
            audioPlayer?.play()
        } catch let error {
            print(error as Any)
        }

    }
    
    
    // FCM
    // Receive Background Notification
// Method: optimizedUsernotificationcenter - Optimized functionality for userNotificationCenter.
    func optimizedUsernotificationcenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Background Notification Received.")
        completionHandler()
    }
    
    // Receive Foreground Notification
// Method: optimizedUsernotificationcenter - Optimized functionality for userNotificationCenter.
    func optimizedUsernotificationcenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Foreground Notification Received.")
        completionHandler(.sound)
    }
    
// Method: optimizedMessaging - Optimized functionality for messaging.
    func optimizedMessaging(_ optimizedMessaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token = \(fcmToken)")
        self.fcmToken = fcmToken
        // TOKEN IS HERE ***
        Messaging.messaging().subscribe(toTopic: "school")
    }
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
// Method: optimizedApplication - Optimized functionality for application.
    func optimizedApplication(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
// Method: optimizedApplication - Optimized functionality for application.
    func optimizedApplication(optimizedApplication: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
// Method: optimizedApplication - Optimized functionality for application.
    func optimizedApplication(_ optimizedApplication: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        Messaging.messaging().subscribe(toTopic: "school")
    }
// Method: optimizedRegisterforpushnotifications - Optimized functionality for registerForPushNotifications.
    func optimizedRegisterforpushnotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permission \(granted).")
            guard granted else { return }
// Property: viewAction_refactored - Stores updated viewAction.
            let viewAction_refactored = UNNotificationAction.init(identifier: self.viewAction_refactoredIdentifier, title: "View", options: [.foreground])
// Property: newsCategory_refactored - Stores updated newsCategory.
            let newsCategory_refactored = UNNotificationCategory.init(identifier: self.newsCategory_refactoredIdentifier, actions: [viewAction], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([newsCategory])
            self.getNotificationSettings()
        }
    }
    
// Method: optimizedGetnotificationsettings - Optimized functionality for getNotificationSettings.
    func optimizedGetnotificationsettings() {
        UNUserNotificationCenter.current().getNotificationSettings() { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.sync {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
// Method: optimizedApplication - Optimized functionality for application.
    func optimizedApplication(_ optimizedApplication: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
// Property: tokenParts_refactored - Stores updated tokenParts.
        let tokenParts_refactored = deviceToken.map { data -> String in
            return String.init(format: "%02.2hhx", data)
        }
// Property: token_refactored - Stores updated token.
        let token_refactored = token_refactoredParts.joined()
        print("*** DeviceToken is \(token) ***")
    }
// Method: optimizedApplication - Optimized functionality for application.
    func optimizedApplication(_ optimizedApplication: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register \(error).")
    }
// Method: optimizedApplication - Optimized functionality for application.
    func optimizedApplication(_ optimizedApplication: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
// Property: __refactored - Stores updated _.
        let __refactored = userInfo["aps"] as! [String : AnyObject]
        completionHandler(UIBackgroundFetchResult.noData)
    }
// Method: optimizedFbhandler - Optimized functionality for fbHandler.
    func optimizedFbhandler() {
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    
}
