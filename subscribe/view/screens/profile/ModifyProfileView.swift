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

    func uploadUserInfo() {
        let uid: String = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()

        db.collection("users").document(uid).setData([
            "name": userName,
            "gender": genderSelection,
            "birthday": Timestamp(date: userBirthday!),
        ])
    }

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

                Spacer()

                Button {
                    showAlert = true
                } label: {
                    Text("수정하기")
                        .padding()
                        .frame(width: windowWidth, alignment: .center)
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
                                uploadUserInfo()
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

            print(userInfoManager.userGender)
        }
        .navigationBarTitle("회원정보 수정", displayMode: .inline)
        .popup(
            isPresented: $showDatePicker,
            closeOnTap: false,
            backgroundColor: .black.opacity(0.5)
        ) {
            DatePickerPopupView(showDatePicker: $showDatePicker, savedDate: $userBirthday)
        }
        .padding(.horizontal, 15)
    }
}

struct ProfileInputView: View {
    @Binding var userName: String
    @Binding var genderSelection: Int
    @Binding var userBirthday: Date?
    @Binding var showDatePicker: Bool

    let genderList: [String] = ["남성", "여성", "공개불가"]

    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
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
//                .frame(width: windowWidth, alignment: .leading)
                .overlay(
                    RoundedRectangle(cornerRadius: 5).stroke(Color(hex: 0xD7D7D7), lineWidth: 0.5)
                )
                .onTapGesture {
                    showDatePicker = true
                }
            }
        }
    }
}

// struct ModifyProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ModifyProfileView()
//    }
// }
