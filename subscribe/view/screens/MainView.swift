//
//  MainView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct MainView: View {
    @State private var selection = 0

    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @State var navigateToCreateView = false

    var body: some View {
        ZStack {
            Color.clear

            NavigationView {
                TabView(selection: $selection) {
                    HomeView(offset: $offset, lastOffset: $lastOffset, navigateToCreateView: $navigateToCreateView)
                        .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }.tag(0)
                    ProfileView().tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }.tag(1)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }

            // Bottom Sheet
            BottomSheetView(offset: $offset, lastOffset: $lastOffset, navigateToCreateView: $navigateToCreateView)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
