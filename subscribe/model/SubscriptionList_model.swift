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

// 이 달의 첫번째 날짜
func firstDayOfMonth(_ date: Date) -> Date {
    var calendar: Calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")

    let components: DateComponents = calendar.dateComponents([.year, .month], from: date)

    return calendar.date(from: components)!
}

// 이 달의 마지막 날짜
func lastDayOfMonth(_ date: Date) -> Date {
    var calendar: Calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")

    let firstDate = firstDayOfMonth(date)
    let nextMonth = calendar.date(byAdding: .month, value: 1, to: firstDate)
    let lastDate = calendar.date(byAdding: .day, value: -1, to: nextMonth!)

    return lastDate!
}

// 해당 요일 개수 구하기
func getWeekday(_ date: Date, _ weekday: Int) -> Int {
    // 요일 개수를 순서대로 담아줄 배열 (일~토)
    var weekDays: [Int] = []

    var calendar: Calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")

    // 해당 월의 시작 날짜와 마지막 날짜
    let firstDate = firstDayOfMonth(date)
    let lastDate = lastDayOfMonth(date)

    // 해당 월의 첫 요일
    let firstWeekday = calendar.dateComponents([.weekday], from: firstDate).weekday!
    // 해당 월의 전체일수
    let lastDay = calendar.dateComponents([.day], from: lastDate).day!

    for _ in 0 ..< 7 {
        weekDays.append(lastDay / 7)
    }

    // 남는 요일에 +1 씩
    for i in 0 ..< lastDay % 7 {
        let dayIndex = firstWeekday + i
        weekDays[(dayIndex - 1) % 7] += 1
    }

    return weekDays[weekday]
}

// 지금이랑 같은 달인지
func isSameMonth(_ date: Date) -> Bool {
    var calendar: Calendar = Calendar(identifier: .gregorian)
    calendar.locale = Locale(identifier: "ko_KR")

    let thisMonth: Int = calendar.dateComponents([.month], from: Date()).month!
    let compareMonth: Int = calendar.dateComponents([.month], from: date).month!

    return thisMonth == compareMonth
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

    // 다음 구독 날짜 계산 메소드
    func nextDateCalculator(_ cycleType: Int, _ cycleValue: String) -> Date {
        let calendar: Calendar = Calendar.current

        let format01: DateFormatter = DateFormatter()
        format01.locale = Locale(identifier: "ko_KR")

        let format02: DateFormatter = DateFormatter()
        format02.locale = Locale(identifier: "ko_KR")

        // 주간구독
        if cycleType == 0 {
            return Date()
        }
        // 월간구독
        else if cycleType == 1 {
            format01.dateFormat = "yyyyMM"
            format02.dateFormat = "dd"

            let date: String = format02.string(from: Date()) // 오늘 일자
            let nextDateString: String = format01.string(from: Date()) + cycleValue // 이번달 구독일

            format01.dateFormat = "yyyyMMdd"

            let nextDate: Date? = format01.date(from: nextDateString) // 날짜로 변환

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

            let todayString: String = format01.string(from: Date())

            let year: Int = calendar.dateComponents([.year], from: Date()).year!
            let nextDate: Date? = format02.date(from: String(year) + cycleValue)

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

        let db: DocumentReference = Firestore.firestore().collection("subscriptions").document(uid ?? "zwYEL3pFT8YCUe3QNeadvFrSFYJ2")

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
