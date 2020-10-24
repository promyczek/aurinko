//
//  FirstLaunchView.swift
//  fasthabit
//
//  Created by Ania on 14/07/2020.
//  Copyright © 2020 Zamora. All rights reserved.
//

import SwiftUI

struct FirstLaunchView: View {
    
    @ObservedObject var settings: UserSettings = UserSettings()
    @State var userName: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Hello Sunshine!")
            TextField("Enter your name", text: $userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disableAutocorrection(true)
            Button(action: {
                self.settings.userName = self.userName
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Ready to start")
            }
        }
    }
}

struct FirstLaunchView_Previews: PreviewProvider {
    static var previews: some View {
        FirstLaunchView()
    }
}
