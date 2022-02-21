//
//  ProfileView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userInfoManager: UserInfoManager
    
    @State var canDelete: Bool = false
    
    @State var showModal = false

    var body: some View {
        ZStack {
            Color(hex: 0xFFFFFF).ignoresSafeArea()
            
            VStack {
                Divider()
                
                Button(action: {
                    userAuth.signOut()
                    userInfoManager.resetUserInfo()
                }, label: {
                    Text("로그아웃")
                    
                    Spacer() 

                    Image(systemName: "chevron.right")
                })
                
                Divider()
                
                Button(action: {
                    showModal = true
//                    Task {
//                       try await userAuth.deleteUser()
//                    }
                }, label: {
                    Text("탈퇴하기")
                    
                    Spacer()

                    Image(systemName: "chevron.right")
                }).sheet(isPresented: self.$showModal) {
                    ReauthenticateView(canDelete: $canDelete)
                }

                
                Divider()
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//    }
//}
