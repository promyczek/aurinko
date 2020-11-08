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
    
    @Environment(\.colorScheme) var colorScheme
    
    let gradientEnd = Color(red: 95.0/255, green: 169.0/255, blue: 244.0/255)
    let gradientStart = Color(red: 79.0/255, green: 178.0/255, blue: 141.0/255)
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [(colorScheme == .light ? .white : gradientStart), (colorScheme == .light ? gradientStart: gradientEnd)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                cirleLayer
                    .animation(.linear(duration: 3))
                
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
            if self.multiplier == 0.8 {
                self.multiplier = 1.0
            } else {
                self.multiplier = 0.8
            }
        }
    }
    
    var cirleLayer: some View {
        ZStack {
            bubble(color: gradientStart)
                .frame(width:300 * multiplier)
                .padding(50)
            bubble(color: gradientStart)
                .frame(width:50 * multiplier)
                .offset(x: 150 * multiplier, y: 280)
            bubble(color: gradientStart)
                .frame(width:30 * multiplier)
                .offset(x: -140 * multiplier, y: 130)
            bubble(color: gradientStart)
                .frame(width:40 * multiplier)
                .offset(x: 100 * multiplier, y: -170)
            bubble(color: gradientStart)
                .frame(width:10 * multiplier)
                .offset(x: -100, y: 190 * multiplier)
        }
    }
    
    var timerView: some View {
        VStack {
            Text("Time for \(isFastingTime ? "fasting" : "eating"). Left:")
            Text(countDownString(from: nowDate, until: (isFastingTime ? self.settings.endTime : self.settings.startTime)))
                .font(.largeTitle)
                .onAppear(perform: {
                    let _ = self.timer
                    let _ = self.animationTimer
                })
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
    
    func bubble(color: Color) -> some View  {
        return Circle()
            .fill(color)
            .blendMode(colorScheme == .light ? .screen : .softLight)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
                .environmentObject(UserSettings())
                .environment(\.colorScheme, .light)
            MainView()
                .environmentObject(UserSettings())
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif
