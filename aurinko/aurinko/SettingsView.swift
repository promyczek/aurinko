//
//  SettingsView.swift
//  aurinko
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
                Picker("Hour", selection: self.$settings.fastingStartHour) {
                    ForEach(0 ..< Self.hours.count) {
                        Text("\(Self.hours[$0])")
                    }
                }
                Picker("Minutes", selection: self.$settings.fastingStartMinutes) {
                    ForEach(0 ..< Self.minutes.count) {
                        Text("\(Self.minutes[$0])")
                    }
                }
            }
            if self.settings.fastingType == 3 {
                Section(header: Text("Fasting end")) {
                    Picker("Hour", selection: self.$settings.fastingEndHour) {
                        ForEach(0 ..< Self.hours.count) {
                            Text("\(Self.hours[$0])")
                        }
                    }
                    Picker("Minutes", selection: self.$settings.fastingEndMinutes) {
                        ForEach(0 ..< Self.minutes.count) {
                            Text("\(Self.minutes[$0])")
                        }
                    }
                }
            }
            
            Section {
                Toggle("Send me notifications", isOn: self.$settings.sendNotifications)
            }
        }.navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
