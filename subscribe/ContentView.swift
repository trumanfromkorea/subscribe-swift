//
//  ContentView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import AuthenticationServices
import FirebaseAuth
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userInfoManager: UserInfoManager
    @EnvironmentObject var uiManager: UIManager

    init() {
        initializeTabBar()
    }

    var body: some View {
        ZStack {
            Color.clear.ignoresSafeArea()

            if !userAuth.isSignedIn {
                LoginView()
                    .onAppear {
                        if Auth.auth().currentUser != nil {
                            userAuth.isSignedIn = true
                        } else {
                            userAuth.isSignedIn = false
                        }
                    }
            } else if userInfoManager.firstLogin == nil {
                LoadingView()
            } else if userInfoManager.firstLogin! {
                NavigationView {
                    SignupView()
                }
            } else {
                MainView()
                    .onAppear {
                        if Auth.auth().currentUser != nil {
                            userAuth.isSignedIn = true
                        } else {
                            userAuth.isSignedIn = false
                        }
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserAuth())
            .environmentObject(UserInfoManager())
            .environmentObject(SubscriptionListManager())
            .environmentObject(CreateItemManager())
            .environmentObject(UIManager())
            .previewInterfaceOrientation(.portrait)
    }
}

// MARK: - Tab bar view appearance

extension ContentView {
    func initializeTabBar() {
//        UITabBar.appearance().tintColor = .blue
        UITabBar.appearance().backgroundColor = UIColor.white
    }
}
