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
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        let storyboardName = launchedBefore ? "Main" : "Onboarding"
        let onboarding = UIStoryboard(name: "Onboarding", bundle: nil)
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = launchedBefore ? main.instantiateInitialViewController()! : onboarding.instantiateViewController(identifier: "OnboardingViewController")
        
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        if launchedBefore  {
            print("not first launch")
        } else {
            print("first launch")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
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


}

