//
//  UserAuth.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import Combine
import FirebaseAuth
import Foundation

class UserAuth: ObservableObject {
    @Published var isSignedIn: Bool = false

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
}
