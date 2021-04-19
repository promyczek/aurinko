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
    static let startTimeKey = "StartTime"
    static let endTimeKey = "EndTime"
    static let sendNotificationsKey = "SendNotifications"
    static let fastingTimeSetKey = "FastingTimeSet"
    static let fastingTypes = ["16/8", "18/6", "20/4", "custom"]
    
    @Published var userName: String = UserDefaults.standard.string(forKey: userNameKey) ?? "" {
        didSet {
            UserDefaults.standard.set(self.userName, forKey: Self.userNameKey)
        }
    }
    @Published var fastingType: Int = UserDefaults.standard.integer(forKey: fastingTypeKey) {
        didSet {
            UserDefaults.standard.set(self.fastingType, forKey: Self.fastingTypeKey)
            specifyEndTime()
            self.isFastingTimeSet = true
        }
    }
    @Published var startTime: Date = UserDefaults.standard.object(forKey: startTimeKey) as? Date ?? Date() {
        didSet {
            UserDefaults.standard.set(self.startTime, forKey: Self.startTimeKey)
            specifyEndTime()
            self.isFastingTimeSet = true
        }
    }
    @Published var endTime: Date = UserDefaults.standard.object(forKey: endTimeKey) as? Date ?? Date() {
        didSet {
            UserDefaults.standard.set(self.endTime, forKey: Self.endTimeKey)
            self.isFastingTimeSet = true
        }
    }
    @Published var sendNotifications: Bool = UserDefaults.standard.bool(forKey: sendNotificationsKey) {
        didSet {
            UserDefaults.standard.set(self.sendNotifications, forKey: Self.sendNotificationsKey)
            if self.sendNotifications {
                let scheduler = LocalNotificationScheduler()
                scheduler.requestAuthorization()
                self.isFastingTimeSet = true
            }
        }
    }
    
    @Published var isFastingTimeSet: Bool = UserDefaults.standard.bool(forKey: fastingTimeSetKey) {
        didSet {
            UserDefaults.standard.set(self.isFastingTimeSet, forKey: Self.fastingTimeSetKey)
        }
    }
    
    private func specifyEndTime() {
        if (fastingType != Self.fastingTypes.firstIndex(of: "custom")) {
            let hoursOfFastingString = String(Self.fastingTypes[fastingType].split(separator: "/")[0])
            if let hoursOfFasting = Double(hoursOfFastingString) {
                endTime = startTime.addingTimeInterval(hoursOfFasting * 60 * 60)
            }
        }
    }
}
