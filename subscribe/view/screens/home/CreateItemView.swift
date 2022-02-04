//
//  CreateItemView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/04.
//

import SwiftUI

enum subscribeCycle {
    case none
    case week
    case month
    case year
}

struct CreateItemView: View {
    @State var cycle: subscribeCycle

    let navigationController = UINavigationController()

    init() {
        navigationController.navigationBar.topItem?.title = ""
        cycle = .none
    }

    var body: some View {
        GeometryReader { proxy in

            let windowWidth = proxy.size.width

            VStack {
                HStack {
                    SubscribeCycleButton(seletedCycle: $cycle, cycleType: .week, windowWidth: windowWidth, cycleText: "주")

                    Spacer()

                    SubscribeCycleButton(seletedCycle: $cycle, cycleType: .month, windowWidth: windowWidth, cycleText: "월")

                    Spacer()

                    SubscribeCycleButton(seletedCycle: $cycle, cycleType: .year, windowWidth: windowWidth, cycleText: "년")
                }
            }
        }
        .padding()
        .navigationBarTitle("구독 추가하기", displayMode: .inline)
    }
}

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
            .background(seletedCycle == cycleType ? Color.white : Color(hex: 0xefefef))
            .cornerRadius(10)
            .onTapGesture {
                seletedCycle = cycleType
            }
    }
}

struct CreateItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateItemView()
    }
}
