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
class AppDelegate: UIResponder, UIApplicationDelegate, AVAudioPlayerDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    fileprivate let viewActionIdentifier = "VIEW_IDENTIFIER"
    fileprivate let newsCategoryIdentifier = "NEWS_CATEGORY"
    
    var window: UIWindow?
    var audioPlayer: AVAudioPlayer?
    var fcmToken = ""

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
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
            let autOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(options: autOptions) { _,_ in
                //
            }
        } else {
            let settings = UIUserNotificationSettings.init(types: [.alert, .badge, .sound], categories: nil)
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

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        NotificationCenter.default.post(name: PUASE_VIDEO_NOTIFY, object: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        NotificationCenter.default.post(name: RESUME_VIDEO_NOTIFY, object: nil)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
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
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Background Notification Received.")
        
        completionHandler()
    }
    
    // Receive Foreground Notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Foreground Notification Received.")
        completionHandler(.sound)
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token = \(fcmToken)")
        self.fcmToken = fcmToken
        // TOKEN IS HERE ***
        Messaging.messaging().subscribe(toTopic: "school")
    }
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func application(received remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        Messaging.messaging().subscribe(toTopic: "school")
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            print("Permission \(granted).")
            guard granted else { return }
            let viewAction = UNNotificationAction.init(identifier: self.viewActionIdentifier, title: "View", options: [.foreground])
            let newsCategory = UNNotificationCategory.init(identifier: self.newsCategoryIdentifier, actions: [viewAction], intentIdentifiers: [], options: [])
            UNUserNotificationCenter.current().setNotificationCategories([newsCategory])
            self.getNotificationSettings()
        }
    }
    
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings() { settings in
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.sync {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String.init(format: "%02.2hhx", data)
        }
        let token = tokenParts.joined()
        print("*** DeviceToken is \(token) ***")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register \(error).")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let _ = userInfo["aps"] as! [String : AnyObject]
        completionHandler(UIBackgroundFetchResult.noData)
    }
    
    func fbHandler() {
        Messaging.messaging().shouldEstablishDirectChannel = true
    }
    
    
    
}

