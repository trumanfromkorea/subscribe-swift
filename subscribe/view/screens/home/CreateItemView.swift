//
//  CreateItemView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/04.
//

import CryptoKit
import FirebaseAuth
import FirebaseFirestore
import SwiftUI
import UIKit

struct CreateItemView: View {
    @EnvironmentObject var createItem: CreateItemManager

    var cycleOptions = ["매주", "매월", "매년"]
    @State var selectedCycle = 3

    @State var subscribeName: String = ""
    @State var subscribeFee: String = ""
    @State var subscribeCycleText: String = ""
    @State var subscribeDate: Date = Date()

    @State var showAlert: Bool = false

    let navigationController = UINavigationController()

    init() {
        navigationController.navigationBar.topItem?.title = ""
    }

    func uploadItem() {
        let uid: String? = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()

        let data = subscribeName.data(using: .utf8)
        let sha256 = SHA256.hash(data: data!)
        let hashString = sha256.compactMap { String(format: "%02x", $0) }.joined()

        db.collection("subscriptions").document(uid ?? "zwYEL3pFT8YCUe3QNeadvFrSFYJ2")
            .collection(createItem.type!).document(hashString).setData([
                "category": createItem.type!,
                "cycleType": selectedCycle,
                "cycleValue": getCycleValue(),
                "fee": subscribeFee,
                "id": hashString,
                "startDate": Timestamp(date: subscribeDate),
                "title": subscribeName,
                "isLastDate": selectedCycle == 1 ? isLastDate() : false,
            ])
    }

    // 월간구독일때 마지막날인지
    func isLastDate() -> Bool {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "dd"

        let lastDate: Date = lastDayOfMonth(subscribeDate)
        let lastDayOfMonth: String = dateFormatter.string(from: lastDate)

        let getDayValue: String = getCycleValue()

        return lastDayOfMonth == getDayValue
    }

    // 구독 주기에 따라 반환하는 값
    // 주간:요일, 월간:날짜, 연간:월일
    func getCycleValue() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")

        if selectedCycle == 0 {
            dateFormatter.dateFormat = "EE"
            return dateFormatter.string(from: subscribeDate)
        } else if selectedCycle == 1 {
            dateFormatter.dateFormat = "dd"
            return dateFormatter.string(from: subscribeDate)
        } else if selectedCycle == 2 {
            dateFormatter.dateFormat = "MMdd"
            return dateFormatter.string(from: subscribeDate)
        } else {
            return ""
        }
    }

    var body: some View {
        GeometryReader { proxy in

            let windowWidth = proxy.size.width

            ScrollView(showsIndicators: false) {
                Group {
                    Spacer().frame(height: 30)
                    SubscribeName(title: "구독 서비스명", placeholder: "구독 서비스명을 입력해주세요", text: $subscribeName)
                }

                Group {
                    Spacer().frame(height: 30)
                    SubscriptionFee(priceText: $subscribeFee)
                }

                Group {
                    Spacer().frame(height: 30)
                    SubscriptionCycle(selectedCycle: $selectedCycle, cycleOptions: cycleOptions, windowWidth: windowWidth)
                }

                Group {
                    Spacer().frame(height: 30)
                    SubscriptionDate(date: $subscribeDate)
                }

                Group {
                    Spacer().frame(height: 30)
                    Button {
                        showAlert = true
                    } label: {
                        Text("추가하기")
                            .padding()
                            .frame(width: windowWidth, alignment: .center)
                            .background(.blue)
                            .foregroundColor(.white)
                            .font(.system(size: 19, weight: .bold))
                            .cornerRadius(10)
                    }.alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("구독 추가"),
                            message: Text("입력하신 내용으로 구독을 추가하시겠습니까?"),
                            primaryButton: .default(Text("닫기")),
                            secondaryButton: .default(
                                Text("확인"),
                                action: {
                                    uploadItem()
                                }
                            )
                        )
                    }
                }

                Spacer().frame(height: 30)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .navigationBarTitle("구독 추가하기", displayMode: .inline)
    }
}

struct CreateItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateItemView()
    }
}
