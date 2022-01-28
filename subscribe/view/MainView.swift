//
//  MainView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 0

    var body: some View {
        ZStack {
            Color.clear
            
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
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
