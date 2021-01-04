//
//  MainTabView.swift
//  fasthabit
//
//  Created by Ania on 04/01/2021.
//

import SwiftUI

struct MainTabView: View {
    
    @EnvironmentObject var settings: UserSettings
    @State private var isPresented = false
    
    static let darkBlue = Color(red: 16.0/255, green: 61.0/255, blue: 105.0/255)
    static let lightGreen = Color(red: 79.0/255, green: 178.0/255, blue: 141.0/255)
    
    var body: some View {
        TabView {
            TimerView()
                .tabItem {
                    Image(systemName: "clock")
                    Text("Timer")
                }
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
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

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
