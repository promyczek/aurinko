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
        return calendar.dateComponents([.hour, .minute, .second], from: date)
    }
    
    static func timeInMinutes(dateComponents: DateComponents) -> Int {
        return (dateComponents.hour ?? 0) * 60 + (dateComponents.minute ?? 0)
    }
    
    static func timeInSeconds(date: Date) -> Int {
        let calendar = Calendar.autoupdatingCurrent
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        var seconds = 0
        seconds += (dateComponents.hour ?? 0) * 60 * 60
        seconds += (dateComponents.minute ?? 0) * 60
        seconds += (dateComponents.second ?? 0)
        
        return seconds
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
            
        } else if (startMinutes >= (12*60) && currentMinutes >= startMinutes) {
            return true
            
        } else if (startMinutes >= (12*60) && currentMinutes < endMinutes) {
            return true
            
        } else {
            return false
            
        }
    }
    
    static func calculateRemaingTime(from startDate: Date, to date: Date) -> Int {
        let now = timeInSeconds(date: startDate)
        let to = timeInSeconds(date: date)
        if (to >= now) {
            return to - now
        } else {
            return to + (24 * 60 * 60) - now
        }
    }
}
