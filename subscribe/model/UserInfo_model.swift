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
    @Published var userGender: Int = -1
    @Published var userBirthday: Date = Date()
    
    @Published var firstLogin: Bool?
    
    init() {
        fetchUserInfo()
    }
    
    func resetUserInfo() {
        self.userName = ""
        firstLogin = nil
    }
    
    func fetchUserInfo() {
        
        let uid: String? = Auth.auth().currentUser?.uid
        
        if uid == nil {
            return
        }
        
        print("사용자 정보를 받아옵니다")
        
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid!)
        
        docRef.getDocument { document, error in
            guard error == nil
            else {
                print("Firestore Read Error : ", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                self.firstLogin = false
                let data = document.data()
                if let data = data {
                    self.userName = data["name"] as? String ?? ""
                    self.userGender = data["gender"] as? Int ?? 2
                    
                    let birthday: Timestamp! = data["birthday"] as? Timestamp
                    self.userBirthday = birthday!.dateValue()
                }
            } else {
                self.firstLogin = true
            }
        }
        
        
    }
}
