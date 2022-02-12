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

enum subscribeCycle {
    case none
    case week
    case month
    case year
}

struct CreateItemView: View {
    @EnvironmentObject var createItem: CreateItemManager

    @State var cycle: subscribeCycle = .none

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
                "cycle": Int(subscribeCycleText)!,
                "cycleNum": 1,
                "fee": subscribeFee,
                "id": hashString,
                "startDate": Timestamp(date: subscribeDate),
                "nextDate": Timestamp(date: subscribeDate),
                "title": subscribeName,
            ])
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
//                    SubscriptionCycle(cycle: $cycle, subscribeCycleText: $subscribeCycleText, windowWidth: windowWidth)
                }

                Picker("구독 갱신 주기를 선택해주세요", selection: $selectedCycle) {
                    ForEach(cycleOptions.indices) { index in
                        Text(self.cycleOptions[index])
                            .tag(cycleOptions[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

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
