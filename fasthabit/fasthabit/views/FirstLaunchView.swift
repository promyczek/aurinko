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
    
    let gradientEnd = Color(red: 95.0/255, green: 169.0/255, blue: 244.0/255)
    let gradientStart = Color(red: 79.0/255, green: 178.0/255, blue: 141.0/255)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [(colorScheme == .light ? .white : gradientStart), (colorScheme == .light ? gradientStart: gradientEnd)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            cirleLayer
                .animation(.linear(duration: 2))
            
            VStack {
                Text("Hello Sunshine!")
                    .font(.title)
                TextField("Enter your name", text: $userName)
                    .frame(width: 200)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                Button(action: {
                    self.settings.userName = self.userName
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Ready to start")
                        .padding()
                        .frame(width:200)
                        .foregroundColor(.white)
                        .background(colorScheme == .light ? gradientStart: gradientEnd)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
    }
    
    var cirleLayer: some View {
        ZStack {
            bubble(color: gradientStart)
                .frame(width:300)
                .padding(50)
            bubble(color: gradientStart)
                .frame(width:50)
                .offset(x: 150, y: 280)
            bubble(color: gradientStart)
                .frame(width:30)
                .offset(x: -140, y: 130)
            bubble(color: gradientStart)
                .frame(width:40)
                .offset(x: 100, y: -170)
            bubble(color: gradientStart)
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

struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchView()
    }
}
