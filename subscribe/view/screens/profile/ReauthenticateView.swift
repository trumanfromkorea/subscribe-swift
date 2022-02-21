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
        SignInWithAppleButtonView(handleResult: handleResult)

        Text(errorText)

        Button {
            
            if canDelete {
                userAuth.deleteUser { result in
                    userInfoManager.resetUserInfo()
                    
                    if case let .failure(error) = result {
                        print(error.localizedDescription)
                    }
                }

            } else {
                errorText = "기다리세요"
            }
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text(canDelete ? "삭제" : "기다려")
        }
    }
}

struct SignInWithAppleButtonView: View {
    @State private var currentNonce: String?
    var handleResult: ((Result<Bool, Error>) -> Void)? = nil
    var body: some View {
        SignInWithAppleButton(.continue,
                              onRequest: { request in
                                  let nonce = FBAuth.randomNonceString()
                                  currentNonce = nonce
                                  request.requestedScopes = [.fullName, .email]
                                  request.nonce = FBAuth.sha256(nonce)
                              },
                              onCompletion: { result in
                                  switch result {
                                  case let .success(authResult):
                                      switch authResult.credential {
                                      case let appleIDCredential as ASAuthorizationAppleIDCredential:
                                          guard let nonce = currentNonce else {
                                              fatalError("Invalid state: A login callback was received, but no login request was sent.")
                                          }
                                          guard let appleIDToken = appleIDCredential.identityToken else {
                                              print("Unable to fetch identity token")
                                              return
                                          }
                                          guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                              print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                              return
                                          }
                                          if let handleResult = handleResult {
                                              FBAuth.reauthenticateWithApple(idTokenString: idTokenString, nonce: nonce) { result in
                                                  handleResult(result)
                                              }
                                          } else {
                                              FBAuth.signInWithApple(idTokenString: idTokenString, nonce: nonce) { result in
                                                  switch result {
                                                  case let .failure(error):
                                                      print(error.localizedDescription)
                                                  case let .success(authDataResult):
                                                      let signInWithAppleRestult = (authDataResult, appleIDCredential)
//                                                      FBAuth.handle(signInWithAppleRestult) { result in
//                                                          switch result {
//                                                          case let .failure(error):
//                                                              print(error.localizedDescription)
//                                                          case .success:
//                                                              print("Successful Login")
//                                                          }
//                                                      }
                                                  }
                                              }
                                          }
                                      default:
                                          break
                                      }
                                  case let .failure(error):
                                      print(error.localizedDescription)
                                  }
                              }
        )
        .frame(width: 200, height: 50)
        .signInWithAppleButtonStyle(.whiteOutline)
    }
}

// struct ReauthenticateView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReauthenticateView()
//    }
// }
