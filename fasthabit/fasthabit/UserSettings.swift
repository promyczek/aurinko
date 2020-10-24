//
//  UserSettings.swift
//  fasthabit
//
//  Created by Ania on 13/07/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import Foundation

class UserSettings: ObservableObject {
    
    static let userNameKey = "UserName"
    static let fastingTypeKey = "FastingType"
    static let startHourKey = "StartHour"
    static let startMinutesKey = "StartMinutes"
    static let endHourKey = "EndHour"
    static let endMinutesKey = "EndMinutes"
    static let sendNotificationsKey = "SendNotifications"
    static let fastingTypes = ["16/8", "18/6", "20/4", "custom"]
    
    @Published var userName: String = UserDefaults.standard.string(forKey: userNameKey) ?? "" {
        didSet {
            UserDefaults.standard.set(self.userName, forKey: Self.userNameKey)
        }
    }
    @Published var fastingType: Int = UserDefaults.standard.integer(forKey: fastingTypeKey) {
        didSet {
            UserDefaults.standard.set(self.fastingType, forKey: Self.fastingTypeKey)
        }
    }
    @Published var fastingStartHour: Int = UserDefaults.standard.integer(forKey: startHourKey) {
        didSet {
            UserDefaults.standard.set(self.fastingStartHour, forKey: Self.startHourKey)
        }
    }
    @Published var fastingStartMinutes: Int = UserDefaults.standard.integer(forKey: startMinutesKey) {
        didSet {
            UserDefaults.standard.set(self.fastingStartMinutes, forKey: Self.startMinutesKey)
        }
    }
    @Published var fastingEndHour: Int = UserDefaults.standard.integer(forKey: endHourKey) {
        didSet {
            UserDefaults.standard.set(self.fastingEndHour, forKey: Self.endHourKey)
        }
    }
    @Published var fastingEndMinutes: Int = UserDefaults.standard.integer(forKey: endMinutesKey) {
        didSet {
            UserDefaults.standard.set(self.fastingEndMinutes, forKey: Self.endMinutesKey)
        }
    }
    @Published var sendNotifications: Bool = UserDefaults.standard.bool(forKey: sendNotificationsKey) {
        didSet {
            UserDefaults.standard.set(self.sendNotifications, forKey: Self.sendNotificationsKey)
            if self.sendNotifications {
                let scheduler = LocalNotificationScheduler()
                scheduler.requestAuthorization()
            }
        }
    }
}
