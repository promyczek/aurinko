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
    @State private var multiplier: CGFloat = 1.0
    
    @State var nowDate: Date = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.white, .blue]), startPoint: .bottom, endPoint: .top).edgesIgnoringSafeArea(.all)
                
                circlesView
                    .animation(.interpolatingSpring(stiffness: 5, damping: 1))
                
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
    }
    
    var settingsButton: some View {
        NavigationLink(destination: SettingsView()) {
            HStack {
                Text("Settings")
            }
        }.buttonStyle(PlainButtonStyle())
    }
    
    var isFastingTime: Bool {
        return FastingTime.isFastingTime(settings: settings)
    }
    
    var timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.nowDate = Date()
        }
    }
    
    var animationTimer: Timer {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) {_ in
            if self.multiplier == 0.9 {
                self.multiplier = 1.0
            } else {
                self.multiplier = 0.9
            }
        }
    }
    
    func countDownString(from nowDate: Date, until date: Date) -> String {
        print("Saved date in UserSettings \(date)")
        //both dates can have different days somewhere in the past, so I cannot count down until "date"
        let secondsLeft = Double(FastingTime.calculateRemaingTime(from: nowDate, to: date))
        let futureDate = nowDate.addingTimeInterval(secondsLeft)
        print("Calculated date in future: \(futureDate)")
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.hour, .minute, .second], from: nowDate, to: futureDate)
        return String(format: "%02dh:%02dm:%02ds", abs(components.hour ?? 00), abs(components.minute ?? 00), abs(components.second ?? 00))
    }
    
    var timerView: some View {
        VStack {
            Text("Time for \(isFastingTime ? "fasting" : "eating"). Left:")
            Text(countDownString(from: nowDate, until: (isFastingTime ? self.settings.endTime : self.settings.startTime)))
                .onAppear(perform: {
                    let _ = self.timer
                    let _ = self.animationTimer
                }).font(.headline)
        }
    }
    
    var circlesView: some View {
        ZStack {
            Circle()
                .fill(Color.green)
                .blendMode(.softLight)
                .frame(width:150)
                .offset(x: -100 * multiplier, y: -100)
            Circle()
                .fill(Color.green)
                .blendMode(.screen)
                .frame(width:300 * multiplier)
                .padding(50)
            Circle()
                .fill(Color.green)
                .blendMode(.screen)
                .frame(width:160)
                .offset(x: 0 * multiplier, y: 150)
            Circle()
                .fill(Color.green)
                .blendMode(.softLight)
                .frame(width:50 * multiplier)
                .offset(x: 150, y: 280)
            Circle()
                .fill(Color.green)
                .blendMode(.screen)
                .frame(width:30 * multiplier)
                .offset(x: -150, y: 160)
            Circle()
                .fill(Color.green)
                .blendMode(.softLight)
                .frame(width:15)
                .offset(x: -140, y: 190 * multiplier)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserSettings())
    }
}
