//
//  ReauthenticateView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/21.
//

import AuthenticationServices
import FirebaseFirestoreSwift
import SwiftUI

struct ReauthenticateView: View {
    @State var errorText: String = ""
    @Binding var canDelete: Bool

    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userInfoManager: UserInfoManager

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

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
        GeometryReader { proxy in
            let windowWidth = proxy.size.width

            VStack(alignment: .leading) {
                HStack {
                    Text("탈퇴하기")
                        .font(.system(size: 25, weight: .bold))
                    
                    Spacer()
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("취소")
                    }
                }
                
                Spacer().frame(height: 30)

                Text("회원 탈퇴를 진행할 시,\n모든 데이터는 삭제되며 다시는 복구할 수 없습니다.")
                    .font(.system(size: 18, weight: .semibold))
                
                Spacer()
                
                Text("이에 동의하신다면 회원 확인 절차를 위해\n아래 버튼을 눌러 인증을 완료한 뒤 탈퇴를 진행해주세요.")
                    .font(.system(size: 15))
                    .foregroundColor(Color(hex: 0x303030))

                if canDelete {
                    Button {
                        userAuth.deleteUser { result in
                            userInfoManager.resetUserInfo()

                            if case let .failure(error) = result {
                                print(error.localizedDescription)
                            }
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("탈퇴 진행하기")
                            .padding()
                            .frame(width: windowWidth, height: 50, alignment: .center)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .bold))
                            .cornerRadius(10)
                    }
                } else {
                    ReauthenticateAppleButton(handleResult: handleResult)
                }
            }
        }
        .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
    }
}

struct ReauthenticateView_Previews: PreviewProvider {
    static var previews: some View {
        ReauthenticateView(canDelete: .constant(true))
    }
}
