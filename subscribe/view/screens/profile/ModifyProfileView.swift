//
//  ModifyProfileView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/03/02.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct ModifyProfileView: View {
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userInfoManager: UserInfoManager
    @EnvironmentObject var subscriptionManager: SubscriptionListManager

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var userName: String = ""
    @State var userBirthday: Date?
    @State var genderSelection: Int = -1
    @State var showDatePicker: Bool = false
    @State var showAlert: Bool = false

    var body: some View {
        let canStart: Bool = userName != "" && userBirthday != nil && genderSelection != -1

        GeometryReader { proxy in

            let windowWidth = proxy.size.width

            VStack {
                
                ProfileInputView(
                    userName: $userName,
                    genderSelection: $genderSelection,
                    userBirthday: $userBirthday,
                    showDatePicker: $showDatePicker
                )
                .padding(.horizontal, 15)

                Spacer()

                Button {
                    showAlert = true
                } label: {
                    Text("수정하기")
                        .padding()
                        .frame(width: windowWidth - 30, alignment: .center)
                        .background(canStart ? .blue : .gray)
                        .foregroundColor(.white)
                        .font(.system(size: 19, weight: .bold))
                        .cornerRadius(10)
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("회원정보 수정"),
                        message: Text("입력하신 내용을 회원정보로 저장하시겠습니까?"),
                        primaryButton: .default(Text("닫기")),
                        secondaryButton: .default(
                            Text("확인"),
                            action: {
                                FBStore.uploadUserInfo(userName: userName, userGender: genderSelection, userBirthday: userBirthday!)
                                userInfoManager.fetchUserInfo()
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        )
                    )
                }
            }
            .padding(.vertical, 20)
        }
        .onAppear {
            userName = userInfoManager.userName
            userBirthday = userInfoManager.userBirthday
            genderSelection = userInfoManager.userGender
        }
        .navigationBarTitle("회원정보 수정", displayMode: .inline)
        .popup(
            isPresented: $showDatePicker,
            closeOnTap: false,
            closeOnTapOutside: true,
            backgroundColor: .black.opacity(0.5)
        ) {
            DatePickerPopupView(showDatePicker: $showDatePicker, savedDate: $userBirthday)
        }
    }
}
