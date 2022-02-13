//
//  DetailsComponents.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/12.
//

import SwiftUI

// 상세보기 제목 부분
struct DetailsTitleView: View {
    var title: String
    var date: String

    var body: some View {
        Spacer().frame(height: 50)

        Text(title)
            .foregroundColor(.black)
            .font(.system(size: 35, weight: .bold))

        Spacer().frame(height: 10)

        HStack(alignment: .bottom) {
            Text("구독 시작일 ")
                .foregroundColor(.gray)
                .font(.system(size: 16))
            Text(date)
                .font(.system(size: 18))
        }

        Divider().frame(height: 30)
    }
}

// 상세보기 정보 부분
struct DetailsInfoView: View {
    var detailsInfo: SubscriptionInfo
    var nextDate: String

    var body: some View {
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
                Text("\(Int(detailsInfo.fee)!) 원")
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))

            HStack {
                SubscriptionInfoKeyText(label: "구독 주기")
                Spacer()
                Text(detailsInfo.cycleType == 0 ? "주간 구독" : detailsInfo.cycleType == 1 ? "월간 구독" : "연간 구독")
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))

            HStack {
                SubscriptionInfoKeyText(label: "다음 결제일")
                Spacer()
                Text(nextDate)
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        }
        .padding()
        .background(Color(hex: 0xF7F7F7))
        .cornerRadius(10)
    }
}
