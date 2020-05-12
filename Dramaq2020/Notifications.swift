//
//  Notifications.swift
//  Dramaq2020
//
//  Created by Петрос Тепоян on 20/4/20.
//  Copyright © 2020 Петрос Тепоян. All rights reserved.
//

import UIKit
import UserNotifications

class DramaqNotification: NSObject, UNUserNotificationCenterDelegate{
    
    static func instantiateNotification(title: String, subtitle: String, body: String, imageName: String?, repeatsEach: TimeInterval, identifier: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.body = body
        content.sound = .default
        if let imageName = imageName {
            if let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") {
                let attachment = try? UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
                if let attachment = attachment {
                    content.attachments = [attachment]
                }
            }
        }
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: repeatsEach, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    static func testNotificate() {
        let content = UNMutableNotificationContent()
        content.title = "Weekly Staff Meeting"
        content.body = "Every Tuesday at 2pm"

        // Configure the recurring date.
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

        dateComponents.minute = 2    // 14:00 hours
           
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(
                 dateMatching: dateComponents, repeats: true)

        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                    content: content, trigger: trigger)

        // Schedule the request with the system.
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
           if error != nil {
              // Handle any errors.
           }
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
        print(response.notification)
        print(response.notification.request)
        print(response.notification.request.identifier)
        
        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }
        
        completionHandler()
    }
}

