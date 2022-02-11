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

                            Text("\(data.fee) 원")
                                .foregroundColor(.black.opacity(0.9))
                                .font(.system(size: 17, weight: .semibold))
                        }

                        HStack(alignment: .bottom) {
                            Text("다음 결제일")
                                .frame(width: 80, alignment: .leading)
                                .font(.system(size: 15))
                                .foregroundColor(Color(hex: 0x454545))

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
