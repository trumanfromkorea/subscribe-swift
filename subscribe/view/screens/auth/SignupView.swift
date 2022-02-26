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

    func uploadUserInfo() {
        let uid: String = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()

        db.collection("users").document(uid).setData([
            "name": userName,
        ])
    }

    var body: some View {
        ZStack {
            GeometryReader { proxy in

                let windowWidth = proxy.size.width
                var canStart: Bool = userName != "" && userBirthday != nil && genderSelection != -1 && agree_01 && agree_02

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

                        Group {
                            Text("별명")
                                .bold()
                            TextField("앱 내에서 사용할 별명을 입력해주세요", text: $userName)
                                .textFieldStyle(.roundedBorder)
                        }

                        Spacer().frame(height: 40)

                        Group {
                            Text("성별")
                                .bold()

                            Picker("", selection: $genderSelection) {
                                ForEach(genderList.indices) { index in
                                    Text(genderList[index]).tag(genderList[index])
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }

                        Spacer().frame(height: 40)

                        Group {
                            Text("생년월일")
                                .bold()

                            HStack {
                                Text(dateFormatter.string(from: userBirthday ?? Date()))
                                Spacer()
                                Image(systemName: "calendar.circle.fill")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.blue)
                            }
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .frame(width: windowWidth, alignment: .leading)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5).stroke(Color(hex: 0xD7D7D7), lineWidth: 0.5)
                            )
                            .onTapGesture {
                                showDatePicker = true
                            }
                        }

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
                                        uploadUserInfo()
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

            if showDatePicker {
                DatePickerPopup(showDatePicker: $showDatePicker, savedDate: $userBirthday)
            }
        }
        .onAppear(perform: {
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy년 M월 d일"

            userBirthday = Date()
        })
        .ignoresSafeArea(.keyboard)
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
