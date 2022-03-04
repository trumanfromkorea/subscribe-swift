//
//  AppleLoginButton.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/26.
//

import SwiftUI
import AuthenticationServices
import FirebaseAuth

struct AppleLoginButton: View {
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userInfoManager: UserInfoManager

    @State var currentNonce: String?
    
    var body: some View {
        SignInWithAppleButton(
            onRequest: { request in
                let nonce = FBAuth.randomNonceString()
                currentNonce = nonce

                request.requestedScopes = [.fullName, .email]
                request.nonce = FBAuth.sha256(nonce)
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
        .frame(width: UIScreen.main.bounds.width - 50, height: 45, alignment: .center)
        .signInWithAppleButtonStyle(.black)
    }
}

struct AppleLoginButton_Previews: PreviewProvider {
    static var previews: some View {
        AppleLoginButton()
    }
}
