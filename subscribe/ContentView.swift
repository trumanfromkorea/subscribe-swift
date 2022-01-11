//
//  ContentView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import AuthenticationServices
import SwiftUI

struct ContentView: View {
        
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        NavigationView {
            if !userAuth.isSignedIn {
                LoginView()
            } else {
                DashboardView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
