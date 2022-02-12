//
//  Fields.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/09.
//

import SwiftUI

// 구독 서비스명
struct SubscribeName: View {
    var title: String
    var placeholder: String

    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .bold))

            TextField(placeholder, text: $text)
                .textFieldStyle(.roundedBorder)
        }
    }
}

// 구독료
struct SubscriptionFee: View {
    @Binding var priceText: String

    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("구독 요금")
                    .font(.system(size: 20, weight: .bold))

                TextField("구독 요금을 입력해주세요", text: $priceText)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
            }
        }
    }
}

// 구독 주기
struct SubscriptionCycle: View {
    @Binding var cycle: subscribeCycle
    @Binding var subscribeCycleText: String

    var windowWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text("갱신 주기")
                .font(.system(size: 20, weight: .bold))
            TextField("구독 갱신 주기를 입력해주세요", text: $subscribeCycleText)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
            HStack {
                SubscribeCycleButton(seletedCycle: $cycle, cycleType: .week, windowWidth: windowWidth, cycleText: "주")
                Spacer()
                SubscribeCycleButton(seletedCycle: $cycle, cycleType: .month, windowWidth: windowWidth, cycleText: "월")
                Spacer()
                SubscribeCycleButton(seletedCycle: $cycle, cycleType: .year, windowWidth: windowWidth, cycleText: "년")
            }

            if subscribeCycleText != "" && cycle != .none {
                let cycleText: String = cycle == .year ? "년" : cycle == .month ? "개월" : "주"
                Text("\(subscribeCycleText)\(cycleText)마다 구독이 갱신됩니다.")
                    .frame(alignment: .leading)
                    .foregroundColor(.gray)
                    .font(.system(size: 15))
            }
        }
    }
}

// 구독 시작 날짜
struct SubscriptionDate: View {
    @Binding var date: Date

    var body: some View {
        VStack(alignment: .leading) {
            Text("구독 시작 날짜")
                .font(.system(size: 20, weight: .bold))
            
            DatePicker("", selection: $date, displayedComponents: .date)
                .labelsHidden()
                .datePickerStyle(.graphical)
        }
    }
}
