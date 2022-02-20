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
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("이번 달 지출 총액")
                    .foregroundColor(Color.black)
                    .font(.system(size: 23, weight: .bold))

                Spacer().frame(height: 5)

                HStack(alignment: .bottom) {
                    Text("결제 완료")
                        .font(.system(size:15))
                        .foregroundColor(Color(hex: 0x454545))
                        .frame(width: 80, alignment: .leading)

                    Text("100,800 원")
                        .font(.system(size:18, weight: .semibold))
                        .foregroundColor(.blue)
                }

                HStack(alignment: .bottom) {
                    Text("지출 총액")
                        .font(.system(size:15))
                        .foregroundColor(Color(hex: 0x454545))
                        .frame(width: 80, alignment: .leading)
                                        
                    let totalFee: Int = subscription.serviceSum + subscription.livingsSum + subscription.etcSum
                    Text("\(totalFee) 원")
                        .font(.system(size:18, weight: .semibold))                     
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

struct TotalCostView_Previews: PreviewProvider {
    static var previews: some View {
        TotalCostView()
    }
}
