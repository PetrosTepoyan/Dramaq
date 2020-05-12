//
//  HomeController+Notifications.swift
//  Dramaq
//
//  Created by Петрос Тепоян on 26/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import UserNotifications

extension HomeController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
        print(response.notification)
        print(response.notification.request)
        print(response.mnotification.request.identifier)
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        completionHandler()
    }
}
