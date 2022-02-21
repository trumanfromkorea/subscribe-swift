//
//  LoginView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import AuthenticationServices
import FirebaseAuth
import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userInfoManager: UserInfoManager

    @State var currentNonce: String?

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            SignInWithAppleButton(
                onRequest: { request in
                    let nonce = randomNonceString()
                    currentNonce = nonce

                    request.requestedScopes = [.fullName, .email]
                    request.nonce = sha256(nonce)
                },
                onCompletion: { result in
                    switch result {
                    case let .success(authResults):
                        switch authResults.credential {
                        case let appleIDCredential as ASAuthorizationAppleIDCredential:

                            guard let nonce = currentNonce else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let appleIDToken = appleIDCredential.identityToken else {
                                fatalError("Invalid state: A login callback was received, but no login request was sent.")
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                return
                            }

                            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                            
                            userAuth.signIn(credential: credential, userInfoManager: userInfoManager)
                            
                        default:
                            break
                        }
                    default:
                        break
                    }
                }
            )
            .frame(width: 280, height: 45, alignment: .center)
            .signInWithAppleButtonStyle(.black)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
