//
//  subscribeApp.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import Firebase
import FirebaseAuth
import SwiftUI

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

// MARK: AppDelegate

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
