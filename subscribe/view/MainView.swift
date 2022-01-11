//
//  MainView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var userAuth: UserAuth
    @State private var selection = 0

    init() {
        // change background color of tabbar
//      UITabBar.appearance().backgroundColor = UIColor.white
//      UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
    }

    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                HomeView().tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(0)
                ProfileView().tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }.tag(1)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
