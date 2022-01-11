//
//  subscribeApp.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct subscribeApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(UserAuth())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
