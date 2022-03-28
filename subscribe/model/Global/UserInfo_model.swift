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
    
    // 사용자 정보 초기화 (로그아웃 혹은 탈퇴 시 사용)
    func resetUserInfo() {
        self.userName = ""
        firstLogin = nil
    }
    
    // 사용자 정보 가져오는 메소드
    func fetchUserInfo() {
        guard let uid: String = Auth.auth().currentUser?.uid
        else {
            return
        }
                
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument { document, error in
            guard error == nil
            else {
                print("Firestore Read Error : ", error ?? "")
                return
            }
            
            // 정보 있으면 첫로그인 X
            if let document = document, document.exists {
                self.firstLogin = false
                let data = document.data()
                if let data = data {
                    self.userName = data["name"] as? String ?? ""
                    self.userGender = data["gender"] as? Int ?? 2
                    
                    let birthday: Timestamp! = data["birthday"] as? Timestamp
                    self.userBirthday = birthday!.dateValue()
                }
            }
            // 정보 없으면 첫 로그인, 정보작성 화면으로 전환
            else {
                self.firstLogin = true
            }
        }
        
        
    }
}
