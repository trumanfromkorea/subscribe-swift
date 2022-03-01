//
//  DeleteUserPopup.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/25.
//

import SwiftUI

struct DeleteUserPopup: View {
    @Binding var showPopup: Bool
    @Binding var canDelete: Bool

    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userInfoManager: UserInfoManager

    @State var errorText: String = ""
    @State var showAlert: Bool = false

    func handleResult(result: Result<Bool, Error>) {
        switch result {
        case .success:
            // Reauthenticated now so you can delete
            canDelete = true

        case let .failure(error):
            errorText = error.localizedDescription
        }
    }

    var body: some View {
//        ZStack {
//            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            

            VStack(alignment: .leading) {
                HStack(alignment: .center) {
                    Text("탈퇴하기")
                        .font(.system(size: 25, weight: .bold))

                    Spacer()

                    Image(systemName: "xmark")
                        .foregroundColor(Color(hex: 0x303030))
                        .background(.white)
                        .onTapGesture {
                            showPopup = false
                        }
                }

                Spacer().frame(height: 20)

                Text("회원 탈퇴를 진행할 시,\n모든 데이터는 삭제되며 다시는 복구할 수 없습니다.")
                    .font(.system(size: 16, weight: .semibold))

                Spacer().frame(height: 10)

                Text("이에 동의하신다면 회원 확인 절차를 위해\n아래 버튼을 눌러 인증을 완료한 뒤 탈퇴를 진행해주세요.")
                    .font(.system(size: 13))
                    .foregroundColor(Color(hex: 0x303030))

                Spacer().frame(height: 15)

                if canDelete {
                    Button(
                        action: {
                            showAlert = true
                        }, label: {
                            Text("탈퇴 진행하기")
                                .padding()
                                .frame(width: 300, height: 40, alignment: .center)
                                .background(.blue)
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .bold))
                                .cornerRadius(10)
                        }
                    ).alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("회원 탈퇴"),
                            message: Text("그동안 SuperScribe 서비스를 이용해주셔서 감사합니다. 확인 버튼을 누르면 탈퇴가 완료됩니다."),
                            primaryButton: .default(Text("취소")),
                            secondaryButton: .default(
                                Text("확인"),
                                action: {
                                    userAuth.deleteUser { result in
                                        userInfoManager.resetUserInfo()

                                        if case let .failure(error) = result {
                                            print(error.localizedDescription)
                                        }
                                    }
                                    showPopup = false
                                }
                            )
                        )
                    }

                } else {
                    ReauthenticateAppleButton(handleResult: handleResult)
                }
            }
            .frame(width: 300)
            .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
            .background(
                Color.white.cornerRadius(20)
            )
//        }
    }
}
