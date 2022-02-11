//
//  Firestore_model.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/11.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseAuth

class UserInfoManager: ObservableObject {
    @Published var userName: String = ""
    
    init() {
        fetchUserInfo()
    }
    
    func fetchUserInfo() {
        
        let uid: String? = Auth.auth().currentUser?.uid
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid ?? "zwYEL3pFT8YCUe3QNeadvFrSFYJ2")
        
        docRef.getDocument { document, error in
            guard error == nil
            else {
                print("Firestore Read Error : ", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    self.userName = data["name"] as? String ?? ""
                }
            }
        }
        
        
    }
}