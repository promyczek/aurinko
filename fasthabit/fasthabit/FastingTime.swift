//
//  FastingTime.swift
//  fasthabit
//
//  Created by Ania on 28/10/2020.
//

import Foundation

class FastingTime {
    
    static func getTimeComponents(date: Date) -> DateComponents {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.dateComponents([.hour, .minute], from: date)
    }
    
    static func timeInMinutes(dateComponents: DateComponents) -> Int {
        return (dateComponents.hour ?? 0) * 60 + (dateComponents.minute ?? 0)
    }
    
    static func isFastingTime(settings: UserSettings) -> Bool {
        let start = getTimeComponents(date: settings.startTime)
        let end = getTimeComponents(date: settings.endTime)
        let current = getTimeComponents(date: Date())
        
        let startMinutes = timeInMinutes(dateComponents: start)
        let endMinutes = timeInMinutes(dateComponents: end)
        let currentMinutes = timeInMinutes(dateComponents: current)
        
        if (startMinutes <= currentMinutes && currentMinutes <= endMinutes) {
            return true
        } else if (startMinutes >= 720 && currentMinutes >= startMinutes) {
            return true
        } else if (startMinutes >= 720 && currentMinutes < endMinutes) {
            return true
        } else {
            return false
        }
    }
    
}
