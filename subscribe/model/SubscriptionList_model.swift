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

// 구독 등록할 때 타입 정하기
class CreateItemManager: ObservableObject {
    @Published var type: String?

    func setService() {
        type = "services"
    }

    func setLiving() {
        type = "livings"
    }

    func setETC() {
        type = "etc"
    }
}


// 구독 리스트 가져오기
class SubscriptionListManager: ObservableObject {
    @Published var serviceList: [SubscriptionInfo]?
    @Published var livingsList: [SubscriptionInfo]?
    @Published var etcList: [SubscriptionInfo]?

    @Published var serviceSum: Int = 0
    @Published var livingsSum: Int = 0
    @Published var etcSum: Int = 0

    init() {
        fetchSubscriptionList()
    }

    // 구독 정보 객체 생성
    func setSubscriptionInfo(_ newData: [String: Any]) -> SubscriptionInfo {
        let startDate: Timestamp! = newData["startDate"] as? Timestamp
        let nextDate: Date = nextDateCalculator(newData["cycleType"] as! Int, newData["cycleValue"] as! String)

        let subscriptionData: SubscriptionInfo = SubscriptionInfo(
            id: newData["id"] as! String,
            category: newData["category"] as! String,
            title: newData["title"] as! String,
            fee: newData["fee"] as! String,
            startDate: startDate!.dateValue(),
            nextDate: nextDate,
            cycleType: newData["cycleType"] as! Int,
            cycleValue: newData["cycleValue"] as! String,
            isLastDate: newData["isLastDate"] as! Bool
        )

        return subscriptionData
    }

    func resetSum(){
        self.serviceSum = 0
        self.livingsSum = 0
        self.etcSum = 0
    }

    // 구독 정보 가져오기
    func fetchSubscriptionList() {
        let uid: String = Auth.auth().currentUser!.uid

        let db: DocumentReference = Firestore.firestore().collection("subscriptions").document(uid)

        resetSum()
        
        // 구독 서비스 가져오기
        fetchServiceList(db)
        // 생활비 지출 가져오기
        fetchLivingsList(db)
        // 기타 지출 가져오기
        fetchEtcList(db)
    }

    // 구독 서비스 가져오기
    func fetchServiceList(_ db: DocumentReference) {
        db.collection("services").getDocuments { snapshot, error in

            self.serviceList = []

            if let error: Error = error {
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
                    self.setServiceSum(data: tempData)
                    self.serviceList!.append(tempData)
                }
            }
        }
    }

    // 구독 지출 합
    func setServiceSum(data: SubscriptionInfo) {
        if data.cycleType == 0 {
            serviceSum += Int(data.fee)! * getWeekday(Date(), Int(data.cycleValue)!)
        } else if data.cycleType == 1 {
            serviceSum += Int(data.fee)!
        } else {
            if isSameMonth(data.startDate) {
                serviceSum += Int(data.fee)!
            }
        }
    }

    // 생활비 지출 가져오기
    func fetchLivingsList(_ db: DocumentReference) {
        db.collection("livings").getDocuments { snapshot, error in

            self.livingsList = []

            if let error: Error = error {
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
                    self.setLivingsSum(data: tempData)
                    self.livingsList!.append(tempData)
                }
            }
        }
    }

    // 생활비 지출 합
    func setLivingsSum(data: SubscriptionInfo) {
        if data.cycleType == 0 {
            livingsSum += Int(data.fee)! * getWeekday(Date(), Int(data.cycleValue)!)
        } else if data.cycleType == 1 {
            livingsSum += Int(data.fee)!
        } else {
            if isSameMonth(data.startDate) {
                livingsSum += Int(data.fee)!
            }
        }
    }

    // 기타 지출 가져오기
    func fetchEtcList(_ db: DocumentReference) {
        db.collection("etc").getDocuments { snapshot, error in

            self.etcList = []

            if let error: Error = error {
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
                    self.setEtcSum(data: tempData)
                    self.etcList!.append(tempData)
                }
            }
        }
    }

    // 생활비 지출 합
    func setEtcSum(data: SubscriptionInfo) {
        if data.cycleType == 0 {
            etcSum += Int(data.fee)! * getWeekday(Date(), Int(data.cycleValue)!)
        } else if data.cycleType == 1 {
            etcSum += Int(data.fee)!
        } else {
            if isSameMonth(data.startDate) {
                etcSum += Int(data.fee)!
            }
        }
    }
}
