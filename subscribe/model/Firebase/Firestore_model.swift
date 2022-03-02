//
//  Firestore_model.swift
//  subscribe
//
//  Created by 장재훈 on 2022/03/03.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct FBStore {
    
    static func uploadUserInfo(userName: String, userGender: Int, userBirthday: Date) {
        let uid: String = Auth.auth().currentUser!.uid
        let db: Firestore = Firestore.firestore()

        db.collection("users").document(uid).setData([
            "name": userName,
            "gender": userGender,
            "birthday": Timestamp(date: userBirthday),
        ])
    }
    
}
