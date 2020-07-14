//
//  ContentView.swift
//  aurinko
//
//  Created by Ania on 14/06/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, World!")
                    .font(.headline)
                Text("tadam")
            }
            .navigationBarTitle("Hello")
            .navigationBarItems(trailing: settingsButton)
            .onAppear() {
                let scheduler = LocalNotificationScheduler()
                scheduler.scheduleNotifications()
            }
        }
    }
    
    var settingsButton: some View {
        NavigationLink(destination: SettingsView()) {
            Image(systemName: "gear")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
