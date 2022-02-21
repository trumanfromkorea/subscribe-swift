//
//  UserAuth.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import Combine
import FirebaseAuth
import FirebaseFirestore
import AuthenticationServices
import Foundation

class UserAuth: ObservableObject {
    @Published var isSignedIn: Bool = false
    @Published var firstLogin: Bool = true

    func signIn(credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { _, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            print("애플 로그인 성공")
            self.isSignedIn = true
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
            print("로그아웃 성공")
        } catch {
            print("로그아웃 오류 - \(error)")
        }
    }

    func deleteUser() async throws {
        let currentUser = Auth.auth().currentUser!
        
        do {
            let token = try await currentUser.getIDToken()
            let appleIdProvider = ASAuthorizationAppleIDProvider().createRequest()
            let appleIdController = ASAuthorizationController(authorizationRequests: [appleIdProvider])
            
            let nonce = randomNonceString()
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: token, rawNonce: nonce)
            
            try await currentUser.reauthenticate(with: credential)
        } catch {
            print("재인증 관련 에러 : \(error)")
        }
        

        let db = Firestore.firestore()

        do {
            try await db.collection("subscriptions").document(currentUser.uid).delete()
            try await db.collection("users").document(currentUser.uid).delete()
            try await Auth.auth().currentUser!.delete()
            self.isSignedIn = false
        } catch {
            print(error)
        }
    }
}
