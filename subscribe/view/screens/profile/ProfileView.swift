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
    @State var showPopup: Bool = false
    @State var logoutAlert: Bool = false

    var body: some View {
        ZStack {
            Color(hex: 0xFFFFFF).ignoresSafeArea()

            ScrollView {
                VStack(alignment: .leading) {
                    Text("프로필")
                        .font(.system(size: 25, weight: .bold))

                    Spacer().frame(height: 30)

                    ProfileContainer(userName: userInfoManager.userName)
                    
                    Spacer().frame(height: 30)

                    Divider()

                    ProfileMenuItem(title: "환경설정")

                    ProfileMenuItem(title: "로그아웃")
                        .onTapGesture {
                            logoutAlert = true
                        }.alert(isPresented: $logoutAlert) {
                            Alert(
                                title: Text("로그아웃"),
                                message: Text("정말 로그아웃 하시겠습니까?"),
                                primaryButton: .default(Text("취소")),
                                secondaryButton: .default(
                                    Text("확인"),
                                    action: {
                                        userAuth.signOut()
                                        userInfoManager.resetUserInfo()
                                    }
                                )
                            )
                        }

                    ProfileMenuItem(title: "탈퇴하기")
                        .onTapGesture {
                            showPopup = true
                        }

                    Divider()
                }
                .padding(EdgeInsets(top: 30, leading: 15, bottom: 0, trailing: 15))
            }

            if showPopup {
                DeleteUserPopup(showPopup: $showPopup, canDelete: $canDelete)
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
