//
//  BottomModalView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/23.
//

import SwiftUI

struct BottomModalView: View {
    
    var body: some View {
        GeometryReader { proxy in

            let width = proxy.frame(in: .global).width
            
            VStack {
                Text("지출 등록하기")
                    .font(.system(size: 25, weight: .bold))
                    .frame(width: width - 60, alignment: .leading)
                    .padding(.top)

                Spacer().frame(height: 25)

                BottomSheetItemView(title: "🧮 구독 서비스 등록하기")
                BottomSheetItemView(title: "🛋 생활비 등록하기")
                BottomSheetItemView(title: "🎸 기타 지출 등록하기")
            }
        }
    }
    
   
}

struct BottomModalView_Previews: PreviewProvider {
    static var previews: some View {
        BottomModalView()
    }
}
