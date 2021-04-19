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
    
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("username: ", text: self.$settings.userName)
            }
            Section(header: Text("Fasting type")) {
                Picker("Intermittent fasting version", selection: self.$settings.fastingType) {
                    ForEach(0 ..< Self.fastingTypes.count) {
                        Text(Self.fastingTypes[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(UserSettings())
    }
}
