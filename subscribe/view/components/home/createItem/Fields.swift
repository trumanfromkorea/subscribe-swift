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
    var isModifyView: Bool

    @Binding var text: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 20, weight: .bold))

            TextField(placeholder, text: $text)
                .textFieldStyle(.roundedBorder)
                .disabled(isModifyView)
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
    
    @Binding var selectedCycle: Int
    
    var cycleOptions: [String]
    var windowWidth: CGFloat

    var body: some View {
        VStack(alignment: .leading) {
            Text("갱신 주기")
                .font(.system(size: 20, weight: .bold))

            Picker("", selection: $selectedCycle) {
                ForEach(cycleOptions.indices) { index in
                    Text(self.cycleOptions[index])
                        .tag(cycleOptions[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
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
