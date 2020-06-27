//
//  SettingsView.swift
//  aurinko
//
//  Created by Ania on 21/06/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    static let fastingTypes = ["16/8", "18/6", "20/4", "custom"]
    static let hours = Array(0...23)
    static let minutes = Array(0...59)
    
    @State private var fastingType = 0
    @State private var fastingStartHour = 15
    @State private var fastingStartMinutes = 30
    @State private var fastingEndHour = 7
    @State private var fastingEndMinutes = 30
    @State private var sendNotifications = false
    
    var body: some View {
        Form {
            Section {
                Picker("Intermittent fasting version", selection: $fastingType) {
                    ForEach(0 ..< Self.fastingTypes.count) {
                        Text(Self.fastingTypes[$0])
                    }
                }
            }
            Section(header: Text("Fasting start")) {
                Picker("Hour", selection: $fastingStartHour) {
                    ForEach(0 ..< Self.hours.count) {
                        Text("\(Self.hours[$0])")
                    }
                }
                Picker("Minutes", selection: $fastingStartMinutes) {
                    ForEach(0 ..< Self.minutes.count) {
                        Text("\(Self.minutes[$0])")
                    }
                }
            }
            if fastingType == 3 {
                Section(header: Text("Fasting end")) {
                    Picker("Hour", selection: $fastingEndHour) {
                        ForEach(0 ..< Self.hours.count) {
                            Text("\(Self.hours[$0])")
                        }
                    }
                    Picker("Minutes", selection: $fastingEndMinutes) {
                        ForEach(0 ..< Self.minutes.count) {
                            Text("\(Self.minutes[$0])")
                        }
                    }
                }
            }
            
            Section {
                Toggle("Send me notifications", isOn: $sendNotifications)
            }
        }.navigationBarTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
