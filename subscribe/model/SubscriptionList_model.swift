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

// 달의 마지막 날짜 구하기
func lastDayOfMonth(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ko_KR")
    dateFormatter.dateFormat = "dd"

    var calendar = Calendar(identifier: .iso8601)
    calendar.locale = Locale(identifier: "ko_KR")

    let components = calendar.dateComponents([.year, .month], from: date)
    let startOfMonth = calendar.date(from: components)!
    let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth)
    let endOfMonth = calendar.date(byAdding: .day, value: -1, to: nextMonth!)

    return dateFormatter.string(from: endOfMonth!)
}

class SubscriptionListManager: ObservableObject {
    @Published var serviceList: [SubscriptionInfo]?
    @Published var livingsList: [SubscriptionInfo]?
    @Published var etcList: [SubscriptionInfo]?

    init() {
        fetchSubscriptionList()
    }

    // 구독 정보 객체 생성
    func setSubscriptionInfo(_ newData: [String: Any]) -> SubscriptionInfo {
        let startDate = newData["startDate"] as? Timestamp
        let nextDate = nextDateCalculator(newData["cycleType"] as! Int, newData["cycleValue"] as! String)

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

    func nextDateCalculator(_ cycleType: Int, _ cycleValue: String) -> Date {
        let calendar = Calendar.current

        let format01 = DateFormatter()
        format01.locale = Locale(identifier: "ko_KR")

        let format02 = DateFormatter()
        format02.locale = Locale(identifier: "ko_KR")

        // 주간구독
        if cycleType == 0 {
            return Date()                                                                        
        }
        // 월간구독
        else if cycleType == 1 {
            format01.dateFormat = "yyyyMM"
            format02.dateFormat = "dd"

            let date = format02.string(from: Date()) // 오늘 일자
            let nextDateString = format01.string(from: Date()) + cycleValue // 이번달 구독일

            format01.dateFormat = "yyyyMMdd"

            let nextDate = format01.date(from: nextDateString) // 날짜로 변환

            if Int(cycleValue)! > Int(date)! { // 아직 구독일자 전일때
                return nextDate!
            } else { // 구독일자 지났을때
                return calendar.date(byAdding: .month, value: 1, to: nextDate!)!
            }

        }
        // 연간구독
        else {
            format01.dateFormat = "MMdd"
            format02.dateFormat = "yyyyMMdd"

            let todayString = format01.string(from: Date())

            let year = calendar.dateComponents([.year], from: Date()).year!
            let nextDate = format02.date(from: String(year) + cycleValue)

            if cycleValue > todayString { // 구독날짜 전일때
                return nextDate!
            } else { // 지났을때
                return calendar.date(byAdding: .year, value: 1, to: nextDate!)!
            }

        }
    }

    // 구독 정보 가져오기
    func fetchSubscriptionList() {
        let uid: String? = Auth.auth().currentUser?.uid

        let db = Firestore.firestore().collection("subscriptions").document(uid ?? "zwYEL3pFT8YCUe3QNeadvFrSFYJ2")

        // 구독 서비스 가져오기
        db.collection("services").getDocuments { snapshot, error in

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
        db.collection("livings").getDocuments { snapshot, error in

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
        db.collection("etc").getDocuments { snapshot, error in

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
