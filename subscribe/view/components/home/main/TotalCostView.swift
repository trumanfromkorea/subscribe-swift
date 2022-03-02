//
//  TotalCostView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import SwiftUI

struct TotalCostView: View {
    @EnvironmentObject var subscription: SubscriptionListManager

    var body: some View {
        HStack(alignment: .bottom) {
            Text("이번 달 지출 총액")
                .foregroundColor(Color.black)
                .font(.system(size: 15, weight: .semibold))

            Spacer().frame(width: 15)

            let totalFee: Int = subscription.serviceSum + subscription.livingsSum + subscription.etcSum
            Text("\(totalFee) 원")
                .font(.system(size: 23, weight: .semibold))
                .foregroundColor(.blue)

            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
        }

        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(hex: 0xFFFFFF))
        .cornerRadius(10)
    }
}
