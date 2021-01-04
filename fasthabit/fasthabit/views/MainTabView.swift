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
    
    var body: some View {
        TabView {
            MainView()
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
