//
//  DetailsView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/04.
//

import SwiftUI

struct DetailsView: View {
    var detailsInfo: SubscriptionInfo

    private let navigationController = UINavigationController()
    private let dateFormatter: DateFormatter = DateFormatter()

    @State var showAlert: Bool = false

//    init() {
//        navigationController.navigationBar.topItem?.title = ""
//    }

    var body: some View {
        GeometryReader { proxy in
            let windowWidth = proxy.size.width

            VStack(alignment: .leading) {
                Spacer().frame(height: 50)

                Text(detailsInfo.title)
                    .foregroundColor(.black)
                    .font(.system(size: 35, weight: .bold))
                
                Spacer().frame(height: 10)

                HStack(alignment: .bottom) {
                    Text("구독 시작일 ")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                    Text(dateFormatter.string(from: detailsInfo.startDate))
                        .font(.system(size: 18))
                }

                Divider().frame(height: 30)

                HStack {
                    Text("정보")
                        .font(.system(size: 22, weight: .bold))
                        .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0))

                    Spacer()

                    Text(detailsInfo.category)
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                        .padding(EdgeInsets(top: 5, leading: 15, bottom: 5, trailing: 15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 100)
                                .stroke(.blue, lineWidth: 2)
                        )
                }

                VStack {
                    HStack {
                        SubscriptionInfoKeyText(label: "구독 요금")
                        Spacer()
                        Text("\(detailsInfo.fee) 원")
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))

                    HStack {
                        SubscriptionInfoKeyText(label: "구독 주기")
                        Spacer()
//                        Text("\(detailsInfo.cycleNum)개월 마다")
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))

                    HStack {
                        SubscriptionInfoKeyText(label: "다음 결제일")
                        Spacer()
                        Text(dateFormatter.string(from: detailsInfo.nextDate))
                    }
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
                .padding()
                .background(Color(hex: 0xF7F7F7))
                .cornerRadius(10)

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
                        secondaryButton: .default(Text("삭제"))
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
//struct DetailsView_Previews: PreviewProvider {
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
//}
