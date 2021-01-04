//
//  FirstLaunchView.swift
//  fasthabit
//
//  Created by Ania on 14/07/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import SwiftUI

struct FirstLaunchView: View {
    
    @EnvironmentObject var settings: UserSettings
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    
    @State var userName: String = ""
    
    let lightMode = [Color.white, MainTabView.lightGreen]
    let darkMode = [MainTabView.lightGreen, MainTabView.darkBlue]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: colorScheme == .light ? lightMode : darkMode), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            cirleLayer
                .animation(.linear(duration: 2))
            
            VStack {
                Text("Hello Sunshine!")
                    .font(.title)
                    .fontWeight(.semibold)
                TextField("Enter your name", text: $userName)
                    .frame(width: 200)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                    .blendMode(colorScheme == .light ? .normal : .colorDodge)
                Button(action: {
                    self.settings.userName = self.userName
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Ready to start")
                        .padding()
                        .frame(width:200)
                        .foregroundColor(.white)
                        .background(colorScheme == .light ? MainTabView.lightGreen: MainTabView.darkBlue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
    }
    
    var cirleLayer: some View {
        ZStack {
            bubble(color: MainTabView.lightGreen)
                .frame(width:300)
                .padding(50)
            bubble(color: MainTabView.lightGreen)
                .frame(width:50)
                .offset(x: 150, y: 280)
            bubble(color: MainTabView.lightGreen)
                .frame(width:30)
                .offset(x: -140, y: 130)
            bubble(color: MainTabView.lightGreen)
                .frame(width:40)
                .offset(x: 100, y: -170)
            bubble(color: MainTabView.lightGreen)
                .frame(width:10)
                .offset(x: -100, y: 190)
        }
    }
    
    func bubble(color: Color) -> some View  {
        return Circle()
            .fill(color)
            .blendMode(colorScheme == .light ? .screen : .softLight)
    }
}

#if DEBUG
struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FirstLaunchView()
                .environmentObject(UserSettings())
                .environment(\.colorScheme, .light)
            FirstLaunchView()
                .environmentObject(UserSettings())
                .environment(\.colorScheme, .dark)
        }
    }
}
#endif
