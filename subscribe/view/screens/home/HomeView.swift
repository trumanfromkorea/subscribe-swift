//
//  HomeView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var userInfoManager: UserInfoManager
    @EnvironmentObject var subscriptionListManager: SubscriptionListManager
    @EnvironmentObject var uiManager: UIManager

    @Binding var navigateToCreateView: Bool
    @Binding var showBottomSheet: Bool


    // 리스트 샘플 데이터
    @State var subscriptionInfoData: [SubscriptionInfo]?

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
                            destination: CreateItemView(isModifyView: false),
                            isActive: self.$navigateToCreateView
                        ) {
                            EmptyView()
                        }
                        
                        // 월간 총 지출
                        TotalCostView()
                        
                        // 구독 모아보기
                        ListGroupView(
                            data: subscriptionListManager.serviceList ?? [],
                            sum: subscriptionListManager.serviceSum,
                            label: "🧮 구독 서비스"
                        )

                        ListGroupView(
                            data: subscriptionListManager.livingsList ?? [],
                            sum: subscriptionListManager.livingsSum,
                            label: "🛋 생활비"
                        )

                        ListGroupView(
                            data: subscriptionListManager.etcList ?? [],
                            sum: subscriptionListManager.etcSum,
                            label: "🎸 기타 지출"
                        )
                        Spacer().frame(height: 40)
                    }
                } // bottom sheet 올라와있으면 스크롤 금지
                .padding(.horizontal, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                

                // 추가 버튼
                FloatingButtonView(showMenuItem: $showBottomSheet)
                    .offset(x: (windowWidth - 50) / 2 - 15, y: (windowHeight - 50) / 2 - 15)

                // 데이터 로딩
                if self.subscriptionListManager.serviceList == nil
                    || self.subscriptionListManager.livingsList == nil
                    || self.subscriptionListManager.etcList == nil
                {
                    LoadingView()
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(navigateToCreateView: .constant(false), showBottomSheet: .constant(true))
            .environmentObject(UserInfoManager())
            .environmentObject(SubscriptionListManager())
    }
}
