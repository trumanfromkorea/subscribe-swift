//
//  firebase_auth_model.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import AuthenticationServices
import CryptoKit
import FirebaseAuth
import Foundation

// firebase 로그인을 위한 random nonce 생성기
// from firebase docs
func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length

    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError(
                    "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                )
            }
            return random
        }

        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }

            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }

    return result
}

// nonce 해시 암호화
func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
    }.joined()

    return hashString
}

// 애플 로그인
func signInWithApple(idTokenString: String,
                     nonce: String,
                     completion: @escaping (Result<AuthDataResult, Error>) -> Void)
{
    // Initialize a Firebase credential.
    let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                              idToken: idTokenString,
                                              rawNonce: nonce)
    // Sign in with Apple.
    Auth.auth().signIn(with: credential) { authDataResult, err in
        if let err = err {
            // Error. If error.code == .MissingOrInvalidNonce, make sure
            // you're sending the SHA256-hashed nonce as a hex string with
            // your request to Apple.
            print(err.localizedDescription)
            completion(.failure(err))
            return
        }
        // User is signed in to Firebase with Apple.
        guard let authDataResult = authDataResult
        else {
            // failure
            return
        }
        completion(.success(authDataResult))
    }
}

func reauthenticateWithApple(idTokenString: String, nonce: String, completion: @escaping (Result<Bool, Error>) -> Void) {
    if let user = Auth.auth().currentUser {
        let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
        user.reauthenticate(with: credential) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}

func deleteUser(completion: @escaping (Result<Bool, Error>) -> Void) {
    if let user = Auth.auth().currentUser {
        user.delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
}
