//
//  ContentView.swift
//  fasthabit
//
//  Created by Ania on 14/06/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var settings: UserSettings
    @State private var isPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, \(settings.userName)!")
                    .font(.headline)
            }
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
                Image(systemName: "gear")
            }
        }.buttonStyle(PlainButtonStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
