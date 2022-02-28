//
//  HomeView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import PartialSheet
import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userInfoManager: UserInfoManager
    @EnvironmentObject var subscriptionListManager: SubscriptionListManager
    @EnvironmentObject var uiManager :UIManager

    @Binding var offset: CGFloat
    @Binding var lastOffset: CGFloat

    @Binding var navigateToCreateView: Bool

    private let inputFormatter: DateFormatter = DateFormatter()
    private let outputDate: DateFormatter = DateFormatter()

    // http request sample code
    @State private var user: User?

    // 리스트 샘플 데이터
    @State var subscriptionInfoData: [SubscriptionInfo]?

    // Formatter 초기화 메소드
    func initialFormatter() {
        inputFormatter.locale = Locale(identifier: "ko_KR")
        inputFormatter.dateFormat = "yyyy-MM-dd"

        outputDate.locale = Locale(identifier: "ko_KR")
        outputDate.dateFormat = "MM월 dd일 (EE)"
    }

    func getBlurRadius() -> CGFloat {
        withAnimation { let progress = -offset / (UIScreen.main.bounds.height - 100)

            return progress * 30
        }
    }

    // 깃헙에 데이터 요청
    func requestData() {
        guard let url = URL(string: "https://api.github.com/users/trumanfromkorea")
        else {
            print("유효한 url 이 아닙니다")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data: Data = data,
               let decodedData: User = try? JSONDecoder().decode(User.self, from: data) {
                self.user = decodedData
                return
            }
            print(error?.localizedDescription ?? "ERROR")
        }.resume()
    }

    var body: some View {
        GeometryReader { proxy in
            let windowWidth = proxy.size.width
            let windowHeight = proxy.size.height

            ZStack {
                Color(hex: 0xF7F7F7).ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 20)

                        Text("\(userInfoManager.userName) 님의 구독 모아보기")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.system(size: 25, weight: .bold))
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 15, trailing: 0))

                        // 구독 생성 화면으로 연결
                        NavigationLink(
                            destination: CreateItemView(),
                            isActive: self.$navigateToCreateView
                        ) {
                            EmptyView()
                        }

                        TotalCostView()
                            .onTapGesture {
                                let manager = LocalNotificationManager()
                                manager.requestPermission()
                                manager.addNotification(title: "테스트 알림")
                                manager.schedule()
                            }

                        ListGroupView(
                            data: subscriptionListManager.serviceList ?? [],
                            sum: subscriptionListManager.serviceSum,
                            label: "🧮 구독 서비스",
                            dateFormatter: outputDate
                        )

                        ListGroupView(
                            data: subscriptionListManager.livingsList ?? [],
                            sum: subscriptionListManager.livingsSum,
                            label: "🛋 생활비",
                            dateFormatter: outputDate
                        )

                        ListGroupView(
                            data: subscriptionListManager.etcList ?? [],
                            sum: subscriptionListManager.etcSum,
                            label: "🎸 기타 지출",
                            dateFormatter: outputDate
                        )
                        Spacer().frame(height: 40)
                    }
                }
                .disabled(offset != 0) // bottom sheet 올라와있으면 스크롤 금지
                .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .blur(radius: getBlurRadius()) // bottom sheet 올라올때 blur
                .navigationTitle("")
                .navigationBarHidden(true)

                // 바텀 시트 올라왔을때 배경 처리
                Color(hex: 0x000000, alpha: offset == 0 ? 0 : 0.5).ignoresSafeArea()

                // 추가 버튼
                FloatingButtonView(offset: $offset, lastOffset: $lastOffset)
                    .offset(x: (windowWidth - 50) / 2 - 15, y: (windowHeight - 50) / 2 - 15)

                // 데이터 로딩
                if self.subscriptionListManager.serviceList == nil
                    || self.subscriptionListManager.livingsList == nil
                    || self.subscriptionListManager.etcList == nil
                {
                    LoadingView()
                }
            }
        }
        .onAppear(perform: {
            // 순서에 유의하자! Formatter 등 뒤에서 사용해야 하는 메소드는 제일 먼저 실행해주기
            initialFormatter()
            requestData()
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(offset: .constant(0), lastOffset: .constant(0), navigateToCreateView: .constant(false))
            .environmentObject(UserInfoManager())
            .environmentObject(SubscriptionListManager())
    }
}
