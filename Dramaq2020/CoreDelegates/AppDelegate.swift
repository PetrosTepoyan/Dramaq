//
//  AppDelegate.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 5/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
//            (granted, error) in
//            guard granted else { return }
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//            }
//        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        // 1. Convert device token to string
//        let tokenParts = deviceToken.map { data -> String in
//            return String(format: "%02.2hhx", data)
//        }
//        let token = tokenParts.joined()
//        // 2. Print device token to use for PNs payloads
//        print("Device Token: \(token)")
//        let bundleID = Bundle.main.bundleIdentifier;
//        print("Bundle ID: \(token) \(bundleID)");
//        // 3. Save the token to local storeage and post to app server to generate Push Notification. ...
//    }
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("failed to register for remote notifications: \(error.localizedDescription)")
//    }
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//        print("Received push notification: \(userInfo)")
//        let aps = userInfo["aps"] as! [String: Any]
//        print("\(aps)")
//    }
    
}


