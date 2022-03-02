//
//  ReauthenticateAppleButton.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/25.
//

import AuthenticationServices
import Foundation
import SwiftUI

struct ReauthenticateAppleButton: View {
    @State private var currentNonce: String?
    var handleResult: ((Result<Bool, Error>) -> Void)? = nil
    
    var body: some View {
        SignInWithAppleButton(
            .continue,
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
                                    let _ = (authDataResult, appleIDCredential)
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
        .frame(width: 300, height: 40)
        .signInWithAppleButtonStyle(.black)
    }
}
