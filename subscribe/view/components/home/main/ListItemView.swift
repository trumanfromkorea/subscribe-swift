//
//  ListItemView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/11.
//

import Foundation
import SwiftUI

struct ListItemView: View {
    var data: SubscriptionInfo
    var dateFormatter: DateFormatter

    var body: some View {
        VStack {
            Spacer().frame(height: 10)
            NavigationLink(destination: DetailsView(detailsInfo: data)) {
                HStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(data.title)
                            .foregroundColor(Color.black)
                            .font(.system(size: 19, weight: .bold))

                        HStack(alignment: .bottom) {
                            Text("결제 금액")
                                .frame(width: 80, alignment: .leading)
                                .font(.system(size: 15))
                                .foregroundColor(Color(hex: 0x454545))

                            Text("\(Int(data.fee)!) 원")
                                .foregroundColor(.black.opacity(0.9))
                                .font(.system(size: 17, weight: .semibold))
                        }

                        HStack(alignment: .bottom) {
                            Text("다음 결제일")
                                .frame(width: 80, alignment: .leading)
                                .font(.system(size: 15))
                                .foregroundColor(Color(hex: 0x454545))
                            
                            var _ = print("실행순서 검사 - 다음날짜")

                            Text("\(dateFormatter.string(from: data.nextDate))")
                                .foregroundColor(.black.opacity(0.9))
                                .font(.system(size: 17, weight: .semibold))
                        }
                    }

                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: 0xFFFFFF))
                .cornerRadius(10)
            }
        }
    }
}

// 리스트 그룹
struct ListGroupView: View {
    var data: [SubscriptionInfo]
    var sum: Int
    var label: String
    var dateFormatter: DateFormatter

    var body: some View {
        VStack {
            if !data.isEmpty {
                HStack(alignment: .bottom) {
                    Text(label)
                        .font(.system(size: 20, weight: .bold))
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 0))

                    Spacer()

                    Text("총 \(sum)원")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(Color.gray)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
                }
            }

            ForEach(data, id: \.self) { data in
                ListItemView(data: data, dateFormatter: dateFormatter)
            }
        }
    }
}
