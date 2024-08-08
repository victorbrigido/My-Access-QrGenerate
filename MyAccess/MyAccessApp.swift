//
//  MyAccessApp.swift
//  MyAccess
//
//  Created by Victor Brigido on 11/03/24.
//

import SwiftUI

@main
struct MyAccessApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            LoginView()
        }
    }
}
