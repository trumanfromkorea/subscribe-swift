//
//  DatePickerPopup.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/25.
//

import Foundation
import SwiftUI

struct DatePickerPopupView: View {
    @Binding var showDatePicker: Bool
    @Binding var savedDate: Date?
    @State var selectedDate: Date = Date()

    var body: some View {
            VStack {
                DatePicker("", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(GraphicalDatePickerStyle())

                Divider()

                HStack {
                    Button(action: {
                        showDatePicker = false
                    }, label: {
                        Text("취소")
                    })

                    Spacer()

                    Button(action: {
                        savedDate = selectedDate
                        showDatePicker = false
                    }, label: {
                        Text("확인")
                            .bold()
                    })
                }
                .padding(.horizontal)
            }
            .frame(width: 300)
            .padding()
            .background(
                Color.white.cornerRadius(20)
            )
   
    }
}
