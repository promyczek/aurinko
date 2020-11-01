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
    @Environment(\.colorScheme) var colorScheme
    
    @State var nowDate: Date = Date()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
                
                circleLayer
                
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
                }).modifier(Title())
        }
    }
    
    func bubble(color: Color, blendMode: BlendMode) -> some View  {
        return Circle().fill(color).blendMode(blendMode)
    }
    
    var circleLayer: some View {
        ZStack {
            firstCirleLayer
                .animation(.linear(duration: 2))
            secondCirleLayer
                .animation(.spring())
        }
    }
    
    var firstCirleLayer: some View {
        ZStack {
            bubble(color: .green, blendMode: .softLight)
                .frame(width:150)
                .offset(x: -100 * multiplier, y: -100)
            bubble(color: .green, blendMode: .screen)
                .frame(width:300 * multiplier)
                .padding(50)
            bubble(color: .green, blendMode: .screen)
                .frame(width:160)
                .offset(x: 0 * multiplier, y: 150)
            bubble(color: .green, blendMode: .screen)
                .frame(width:50 * multiplier)
                .offset(x: 150, y: 280)
            bubble(color: .green, blendMode: .screen)
                .frame(width:30 * multiplier)
                .offset(x: -150, y: 160)
            bubble(color: .green, blendMode: .softLight)
                .frame(width:15)
                .offset(x: -140, y: 190 * multiplier)
        }
    }
    
    var secondCirleLayer: some View {
        ZStack {
            bubble(color: .red, blendMode: .softLight)
                .frame(width:100)
                .offset(x: -130 * multiplier, y: 0)
            bubble(color: .red, blendMode: .screen)
                .frame(width:120)
                .offset(x: 20 * multiplier, y: -170)
            bubble(color: .red, blendMode: .softLight)
                .frame(width:50 * multiplier)
                .offset(x: 150, y: 100)
            bubble(color: .red, blendMode: .screen)
                .frame(width:30 * multiplier)
                .offset(x: -130, y: 130)
            bubble(color: .red, blendMode: .softLight)                .frame(width:15)
                .offset(x: -140, y: 100 * multiplier)
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(UserSettings())
    }
}
