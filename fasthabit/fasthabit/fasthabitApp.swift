//
//  fasthabitApp.swift
//  fasthabit
//
//  Created by Ania on 24/10/2020.
//

import SwiftUI

@main
struct fasthabitApp: App {
    
    var settings = UserSettings()
    
    var body: some Scene {
        WindowGroup {
            MainTabView().environmentObject(settings)
        }
    }
}
