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

    func signIn(credential: AuthCredential, userInfoManager: UserInfoManager) {
        Auth.auth().signIn(with: credential) { _, error in
            if error != nil {
                print(error?.localizedDescription as Any)
                return
            }
            
            userInfoManager.fetchUserInfo()
            
            self.isSignedIn = true
            
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            isSignedIn = false
        } catch {
            print("로그아웃 오류 - \(error)")
        }
    }

    func deleteUser(completion: @escaping (Result<Bool, Error>) -> Void)  {
        let currentUser = Auth.auth().currentUser!
        let db = Firestore.firestore()
        
        db.collection("subscriptions").document(currentUser.uid).delete { subResult in
            db.collection("users").document(currentUser.uid).delete { userResult in
                currentUser.delete { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        self.isSignedIn = false
                        completion(.success(true))
                    }
                }
            }
        }
        
      
    }
}
