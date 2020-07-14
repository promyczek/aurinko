//
//  LocalNotificationScheduler.swift
//  aurinko
//
//  Created by Ania on 14/07/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import Foundation
import UserNotifications

class LocalNotificationScheduler {
    
    let center = UNUserNotificationCenter.current()
    var settings: UserSettings? = nil
    
    func scheduleNotifications() {
        guard let userSettings = settings else {
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = "Hello Sunshine"
        content.body = "It's time to start your fasting! Good luck!"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "alarm"
        
        var dateComponets = DateComponents()
        dateComponets.hour = userSettings.fastingStartHour
        dateComponets.minute = userSettings.fastingStartMinutes
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponets, repeats: true)
        let request = UNNotificationRequest(identifier: "startFasting", content: content, trigger: trigger)
        center.add(request)
    }
    
    func requestAuthorization(for settings: UserSettings) {
        self.settings = settings
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                self.scheduleNotifications()
            } else {
                print("User did not granted")
            }
        }
    }
}
