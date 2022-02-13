//
//  DetailsView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/04.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct DetailsView: View {
    var detailsInfo: SubscriptionInfo

    private let navigationController = UINavigationController()
    private let dateFormatter: DateFormatter = DateFormatter()

    @State var showAlert: Bool = false

    // 아이템 삭제
    func deleteItem() {
        let uid: String = Auth.auth().currentUser!.uid
        let docId: String = detailsInfo.id
        let category: String = detailsInfo.category

        let docRef: DocumentReference = Firestore.firestore().collection("subscriptions").document(uid)

        docRef.collection(category).document(docId).delete { error in
            if let error: Error = error {
                print("삭제 오류 : \(error)")
            } else {
                print("삭제되었습니다")
            }
        }
    }

//    init() {
//        navigationController.navigationBar.topItem?.title = ""
//    }

    var body: some View {
        GeometryReader { proxy in
            let windowWidth = proxy.size.width

            VStack(alignment: .leading) {
                DetailsTitleView(
                    title: detailsInfo.title,
                    date: dateFormatter.string(from: detailsInfo.startDate)
                )

                DetailsInfoView(
                    detailsInfo: detailsInfo,
                    nextDate: dateFormatter.string(from: detailsInfo.nextDate)
                )

                Spacer()

                Button {
                    print("편집하기 버튼 클릭")
                } label: {
                    Text("편집하기")
                        .padding()
                        .frame(width: windowWidth, alignment: .center)
                        .background(.gray)
                        .foregroundColor(.white)
                        .font(.system(size: 19, weight: .bold))
                        .cornerRadius(10)
                }

                Button {
                    showAlert = true
                } label: {
                    Text("삭제하기")
                        .padding()
                        .frame(width: windowWidth, alignment: .center)
                        .background(.red)
                        .foregroundColor(.white)
                        .font(.system(size: 19, weight: .bold))
                        .cornerRadius(10)
                }.alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("삭제"),
                        message: Text("정말 삭제하시겠습니까? 삭제한 데이터는 복구가 불가능합니다."),
                        primaryButton: .default(Text("취소")),
                        secondaryButton: .default(Text("삭제"), action: { deleteItem() })
                    )
                }
            }
        }
        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
        .navigationBarTitle("상세보기", displayMode: .inline)
        .onAppear(perform: {
            dateFormatter.locale = Locale(identifier: "ko_KR")
            dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        })
    }
}

struct SubscriptionInfoKeyText: View {
    var label: String

    var body: some View {
        Text(label)
            .foregroundColor(Color(hex: 0x282828))
            .font(.system(size: 18, weight: .bold))
    }
}

//
// struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView(
//            detailsInfo: SubscriptionInfo(
//                id: "1",
//                category: "구독 서비스",
//                title: "유튜브 프리미엄",
//                fee: "14000",
//                startDate: Date(),
//                nextDate: Date(),
//                cycle: 1,
//                cycleNum: 1
//            )
//        )
//    }
// }
