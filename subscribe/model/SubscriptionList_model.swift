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
    @Published var serviceList: [SubscriptionInfo]?
    @Published var livingsList: [SubscriptionInfo]?
    @Published var etcList: [SubscriptionInfo]?

    init() {
        fetchSubscriptionList()
    }

    func setSubscriptionInfo(_ newData: [String: Any]) -> SubscriptionInfo{
        
        let startDate = newData["startDate"] as? Timestamp
        let nextDate = newData["nextDate"] as? Timestamp
        
        let subscriptionData: SubscriptionInfo = SubscriptionInfo(
            id: newData["id"] as! String,
            category: newData["category"] as! String,
            title: newData["title"] as! String,
            fee: newData["fee"] as! String,
            startDate: startDate!.dateValue(),
            nextDate: nextDate!.dateValue(),
            cycle: newData["cycle"] as! Int,
            cycleNum: newData["cycleNum"] as! Int
        )
        
        return subscriptionData;
    }

    func fetchSubscriptionList() {
        let uid: String? = Auth.auth().currentUser?.uid

        let db = Firestore.firestore()

        // 구독 서비스 가져오기
        db.collection("subscriptions").document(uid ?? "zwYEL3pFT8YCUe3QNeadvFrSFYJ2")
            .collection("services").getDocuments { snapshot, error in

                self.serviceList = []

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
                        let tempData: SubscriptionInfo = self.setSubscriptionInfo(document.data())
                        self.serviceList!.append(tempData)
                    }
                }
            }
        
        // 생활비 지출 가져오기
        db.collection("subscriptions").document(uid ?? "zwYEL3pFT8YCUe3QNeadvFrSFYJ2")
            .collection("livings").getDocuments { snapshot, error in

                self.livingsList = []

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
                        let tempData: SubscriptionInfo = self.setSubscriptionInfo(document.data())
                        self.livingsList!.append(tempData)
                    }
                }
            }
        
        // 기타 지출 가져오기
        db.collection("subscriptions").document(uid ?? "zwYEL3pFT8YCUe3QNeadvFrSFYJ2")
            .collection("etc").getDocuments { snapshot, error in

                self.etcList = []

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
                        let tempData: SubscriptionInfo = self.setSubscriptionInfo(document.data())
                        self.etcList!.append(tempData)
                    }
                }
            }
    }
}
