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

    @State var showBottomSheet = false

    var body: some View {
        ZStack {
            Color.clear

            NavigationView {
                TabView(selection: $selection) {
                    HomeView(navigateToCreateView: $navigateToCreateView, showBottomSheet: $showBottomSheet)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("홈")
                        }
                        .tag(0)

                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.fill")
                            Text("프로필")
                        }
                        .tag(1)
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }

        }
        .edgesIgnoringSafeArea(.all)
        .popup(
            isPresented: $showBottomSheet,
            type: .toast,
            position: .bottom,
            closeOnTap: false,
            closeOnTapOutside: true,
            backgroundColor: .black.opacity(0.5)
        ) {
            BottomSheetView(navigateToCreateView: $navigateToCreateView, showBottomSheet: $showBottomSheet)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
