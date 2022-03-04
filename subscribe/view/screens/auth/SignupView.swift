//
//  SignupView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/20.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct SignupView: View {
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userInfoManager: UserInfoManager
    @EnvironmentObject var subscriptionManager: SubscriptionListManager
    @EnvironmentObject var uiManager: UIManager

    @State var userName: String = ""
    @State var userBirthday: Date?

    @State var showDatePicker: Bool = false
    @State var showAlert: Bool = false
    @State var genderSelection: Int = -1

    @State var agreeAll: Bool = false
    @State var agree_01: Bool = false
    @State var agree_02: Bool = false
    @State var agree_03: Bool = false

    let genderList: [String] = ["남성", "여성", "공개불가"]
    let dateFormatter: DateFormatter = DateFormatter()

    var body: some View {
        ZStack {
            GeometryReader { proxy in

                let windowWidth = proxy.size.width
                let canStart: Bool = userName != "" && userBirthday != nil && genderSelection != -1 && agree_01 && agree_02

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Group {
                            Spacer().frame(height: 20)
                            Text("환영합니다! 👋")
                                .font(.system(size: 30))
                                .bold()
                            Spacer().frame(height: 10)
                            Text("서비스를 시작하기 전,\n회원님에 대한 몇 가지 추가정보를 입력해주세요.")
                                .font(.system(size: 15))
                                .foregroundColor(.gray)
                        }

                        Spacer().frame(height: 40)

                        ProfileInputView(
                            userName: $userName,
                            genderSelection: $genderSelection,
                            userBirthday: $userBirthday,
                            showDatePicker: $showDatePicker
                        )

                        AgreePolicy(agreeAll: $agreeAll, agree_01: $agree_01, agree_02: $agree_02, agree_03: $agree_03)
                            .padding(EdgeInsets(top: 40, leading: 0, bottom: 20, trailing: 0))

                        Button {
                            showAlert = true
                        } label: {
                            Text("시작하기")
                                .padding()
                                .frame(width: windowWidth, alignment: .center)
                                .background(canStart ? .blue : .gray)
                                .foregroundColor(.white)
                                .font(.system(size: 19, weight: .bold))
                                .cornerRadius(10)
                        }.alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("시작하기"),
                                message: Text("입력하신 내용을 회원정보로 저장하시겠습니까?"),
                                primaryButton: .default(Text("닫기")),
                                secondaryButton: .default(
                                    Text("확인"),
                                    action: {
                                        FBStore.uploadUserInfo(userName: userName, userGender: genderSelection, userBirthday: userBirthday!)
                                        subscriptionManager.fetchSubscriptionList()
                                        userAuth.isSignedIn = true
                                        userInfoManager.fetchUserInfo()
                                    }
                                )
                            )
                        }
                        .disabled(!canStart)

                        Spacer().frame(height: 40)
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        }
        .popup(
            isPresented: $showDatePicker,
            closeOnTap: false,
            backgroundColor: .black.opacity(0.5)
        ) {
            DatePickerPopupView(showDatePicker: $showDatePicker, savedDate: $userBirthday)
        }
        .onAppear(perform: {
            uiManager.setNavigationBarHidden()
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy년 M월 d일"

            userBirthday = Date()
        })
        .ignoresSafeArea(.keyboard)
        .navigationBarTitle("")
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
