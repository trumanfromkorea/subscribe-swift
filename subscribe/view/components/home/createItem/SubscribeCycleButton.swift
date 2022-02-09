//
//  SubscribeCycleButton.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/09.
//

import SwiftUI

struct SubscribeCycleButton: View {
    @Binding var seletedCycle: subscribeCycle

    var cycleType: subscribeCycle
    var windowWidth: CGFloat
    var cycleText: String

    var body: some View {
        Text(cycleText)
            .foregroundColor(seletedCycle == cycleType ? Color.blue : Color(hex: 0x8B8B8B))
            .padding(EdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0))
            .frame(width: windowWidth * 0.3, alignment: .center)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(seletedCycle == cycleType ? Color.blue : Color(hex: 0x8B8B8B), lineWidth: 2)
            )
            .background(seletedCycle == cycleType ? Color.white : Color(hex: 0xEFEFEF))
            .cornerRadius(10)
            .onTapGesture {
                seletedCycle = cycleType
            }
    }
}
