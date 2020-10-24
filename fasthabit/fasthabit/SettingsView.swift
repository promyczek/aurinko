//
//  SettingsView.swift
//  fasthabit
//
//  Created by Ania on 21/06/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var settings: UserSettings
    
    static let fastingTypes = UserSettings.fastingTypes
    static let hours = Array(0...23)
    static let minutes = Array(0...59)
    
    @State private var fastingStart = defaultFastingTime
    @State private var fastingEnd = defaultFastingTime
    
    var body: some View {
        Form {
            Section {
                Picker("Intermittent fasting version", selection: self.$settings.fastingType) {
                    ForEach(0 ..< Self.fastingTypes.count) {
                        Text(Self.fastingTypes[$0])
                    }
                }
            }
            Section(header: Text("Fasting start")) {
                DatePicker("Please enter fasting start time", selection: self.$settings.startTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
            }
            if self.settings.fastingType == 3 {
                Section(header: Text("Fasting end")) {
                    DatePicker("Please enter fasting end time", selection: self.$settings.endTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .datePickerStyle(WheelDatePickerStyle())
                }
            }
            
            Section {
                Toggle("Send me notifications", isOn: self.$settings.sendNotifications)
            }
        }.navigationBarTitle("Settings")
    }
    
    static var defaultFastingTime: Date {
        var components = DateComponents()
        components.hour = 16
        components.minute = 30
        return Calendar.current.date(from: components) ?? Date()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
