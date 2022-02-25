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

            ScrollView{
                VStack(alignment: .leading) {
                    
                    Text("프로필")
                        .font(.system(size: 25, weight: .bold))

                    Spacer().frame(height: 30)

                    HStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 55, height: 55)
                            .foregroundColor(Color(hex: 0xD1D1D1))
                        
                        Spacer().frame(width: 10)

                        VStack(alignment: .leading) {
                            Text("장재훈")
                                .font(.system(size: 20))
                                .bold()
                            
                            Spacer().frame(height: 5)
                            
                            Text("프로필 편집")
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))

                    
                    Spacer().frame(height: 30)

                    Divider()

                    ProfileMenuItem(title: "환경설정")

                    ProfileMenuItem(title: "로그아웃")
                        .onTapGesture {
                            userAuth.signOut()
                            userInfoManager.resetUserInfo()
                        }

                    ProfileMenuItem(title: "탈퇴하기")
                        .onTapGesture {
                            showModal = true
                        }

                    Divider()
                }
                .padding(EdgeInsets(top: 30, leading: 15, bottom: 0, trailing: 15))
            }
            
            if showModal {
                DeleteUserPopup(showPopup: $showModal, canDelete: $canDelete)
            }
            
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
