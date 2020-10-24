//
//  LocalNotificationScheduler.swift
//  fasthabit
//
//  Created by Ania on 14/07/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationScheduler {
    
    let center = UNUserNotificationCenter.current()
    var userSettings: UserSettings = UserSettings()
    
    func scheduleNotifications() {
        
        let content = UNMutableNotificationContent()
        content.title = "Hello Sunshine"
        content.body = "It's time to start your fasting! Good luck!"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "alarm"
        
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: userSettings.startTime)
        let startHour = dateComponents.hour ?? 0
        
        registerNotification(content: content, dateComponents: dateComponents, identifier: "startFasting")
        
        content.body = "Congrats! you can eat now! Enjoy your meals!"
        let fastingTypes = UserSettings.fastingTypes
        if fastingTypes[userSettings.fastingType] == "custom" {
            dateComponents = Calendar.current.dateComponents([.hour, .minute], from: userSettings.endTime)
        } else {
            let fastingHoursString = fastingTypes[userSettings.fastingType].split(separator: "/")[0]
            if let fastingHours = Int(fastingHoursString) {
                dateComponents.hour = (startHour + fastingHours) % 24
            }
        }
        
        registerNotification(content: content, dateComponents: dateComponents, identifier: "endFasting")
    }
    
    func registerNotification(content: UNMutableNotificationContent, dateComponents: DateComponents, identifier: String) {
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request)
    }
    
    func requestAuthorization() {
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("Notifications granted")
            } else {
                print("User did not granted")
            }
        }
    }
}
