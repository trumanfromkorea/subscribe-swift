//
//  TotalCostView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import SwiftUI

struct TotalCostView: View {
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            Text("이번 달 지출 총액").foregroundColor(Color.black)
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("결제 완료").foregroundColor(Color.black)
                    Text("99,000 원").foregroundColor(Color.black)
                }
                Spacer()
                VStack(alignment: .leading, spacing: 5) {
                    Text("지출 총액").foregroundColor(Color.black)
                    Text("108,990 원").foregroundColor(Color.black)
                }
            }
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
