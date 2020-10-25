//
//  MainView.swift
//  fasthabit
//
//  Created by Ania on 14/06/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var settings: UserSettings
    @State private var isPresented = false
    
    @State var nowDate: Date = Date()
    
    var body: some View {
        NavigationView {
            timerView
            .navigationBarTitle(settings.userName.isEmpty ? "Hello Sunshine!" : "Hello \(settings.userName)")
            .navigationBarItems(trailing: settingsButton)
            .onAppear() {
                if settings.userName.isEmpty {
                    isPresented = true
                }
                
                let scheduler = LocalNotificationScheduler()
                scheduler.scheduleNotifications()
            }
            .fullScreenCover(isPresented: $isPresented, content: FirstLaunchView.init)
        }
    }
    
    var settingsButton: some View {
        NavigationLink(destination: SettingsView()) {
            HStack {
                Text("Settings")
            }
        }.buttonStyle(PlainButtonStyle())
    }
    
    var isFastingTime: Bool {
        //BUG what if you start fastig on 7PM and
        let startTime =  60 * Calendar.current.component(.hour, from: self.settings.startTime) + Calendar.current.component(.minute, from: self.settings.startTime)
        let endTime = 60 * Calendar.current.component(.hour, from: self.settings.endTime) + Calendar.current.component(.minute, from: self.settings.endTime)
        
        let now = Date()
        let nowInMinutes = 60 * Calendar.current.component(.hour, from: now) + Calendar.current.component(.minute, from: now)
        if nowInMinutes >= startTime && nowInMinutes <= endTime {
            return true
        } else {
            return false
        }
    }
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    func countDownString(from date: Date, until nowDate: Date) -> String {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.hour, .minute, .second], from: nowDate, to: date)
        return String(format: "%02dh:%02dm:%02ds",
                      abs(components.hour ?? 00),
                      abs(components.minute ?? 00),
                      abs(components.second ?? 00))
    }
    
    var timerView: some View {
        VStack {
            Text("Time for \(isFastingTime ? "fasting" : "eating"). Left:")
            Text(countDownString(from: nowDate, until: (isFastingTime ? self.settings.endTime : self.settings.startTime)))
                .onAppear(perform: {
                    let _ = self.timer
                }).font(.headline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
