//
//  SceneDelegate.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 5/3/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        
        
        
        let mainStoryboard = UIStoryboard(name: launchedBefore ? "Main" : "Onboarding", bundle: nil)
        let VC = launchedBefore ? mainStoryboard.instantiateInitialViewController() as! HomeController : mainStoryboard.instantiateViewController(withIdentifier: "OnboardingViewController") as! OnboardingViewController
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = VC
        window?.makeKeyAndVisible()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window = window
        
        if launchedBefore  {
            print("not first launch")
        } else {
            print("first launch")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

