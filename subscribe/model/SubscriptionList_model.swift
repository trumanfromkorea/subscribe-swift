//
//  SubscriptionList_model.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/11.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import Foundation

class SubscriptionListManager: ObservableObject {
    @Published var subscriptionList: [SubscriptionInfo]?

    init() {
        fetchSubscriptionList()
    }

    func fetchSubscriptionList() {
        let uid: String? = Auth.auth().currentUser?.uid

        let db = Firestore.firestore()
        
        db.collection("subscriptions").document(uid!)
            .collection("services").getDocuments { snapshot, error in
                
                self.subscriptionList = []
                
                if let error = error {
                    print("Error getting Docs : \(error)")
                    return
                } else {
                    
                    // 문서가 비었을 때
                    if snapshot!.documents.isEmpty {
                        return
                    }
                    
                    // 있으면 데이터 추가
                    for document in snapshot!.documents {

                        let newData = document.data()
                        
                        let startDate = newData["startDate"] as? Timestamp
                        let nextDate = newData["nextDate"] as? Timestamp

                        let tempData: SubscriptionInfo = SubscriptionInfo(
                            id: newData["id"] as! String,
                            category: newData["category"] as! String,
                            title: newData["title"] as! String,
                            fee: newData["fee"] as! String,
                            startDate: startDate!.dateValue(),
                            nextDate: nextDate!.dateValue(),
                            cycle: newData["cycle"] as! Int,
                            cycleNum: newData["cycleNum"] as! Int
                        )
                        
                        self.subscriptionList!.append(tempData)
                    }
                }
            }
    }
}
