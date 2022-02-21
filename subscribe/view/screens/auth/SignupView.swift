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

    @State var userName: String = ""
    @State var showAlert: Bool = false

    func uploadUserInfo() {
        let uid: String = Auth.auth().currentUser!.uid
        let db = Firestore.firestore()

        db.collection("users").document(uid).setData([
            "name": userName,
        ])
    }

    var body: some View {
        GeometryReader { proxy in

            let windowWidth = proxy.size.width

            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)

                TextField("이름을 입력해주세요", text: $userName)
                    .textFieldStyle(.roundedBorder)

                Group {
                    Spacer().frame(height: 30)
                    Button {
                        showAlert = true
                    } label: {
                        Text("시작하기")
                            .padding()
                            .frame(width: windowWidth, alignment: .center)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .bold))
                            .cornerRadius(10)
                    }.alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("시작하기"),
                            message: Text("입력하신 내용으로 구독을 추가하시겠습니까?"),
                            primaryButton: .default(Text("닫기")),
                            secondaryButton: .default(
                                Text("확인"),
                                action: {
                                    uploadUserInfo()
                                    userAuth.isSignedIn = true
                                    userInfoManager.firstLogin = false
                                }
                            )
                        )
                    }
                }
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
