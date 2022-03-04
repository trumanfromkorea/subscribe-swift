//
//  ProfileInputView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/03/03.
//

import Foundation
import SwiftUI

struct ProfileInputView: View {
    @Binding var userName: String
    @Binding var genderSelection: Int
    @Binding var userBirthday: Date?
    @Binding var showDatePicker: Bool

    let genderList: [String] = ["남성", "여성", "공개불가"]

    let dateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일"
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text("별명")
                    .bold()
                TextField("앱 내에서 사용할 별명을 입력해주세요", text: $userName)
                    .textFieldStyle(.roundedBorder)
            }

            Spacer().frame(height: 40)

            Group {
                Text("성별")
                    .bold()

                Picker("", selection: $genderSelection) {
                    ForEach(genderList.indices) { index in
                        Text(genderList[index]).tag(genderList[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Spacer().frame(height: 40)

            Group {
                Text("생년월일")
                    .bold()

                HStack {
                    Text(dateFormatter.string(from: userBirthday ?? Date()))
                    Spacer()
                    Image(systemName: "calendar.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.blue)
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .background(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 5).stroke(Color(hex: 0xD7D7D7), lineWidth: 0.5)
                )
                .onTapGesture {
                    showDatePicker = true
                }
            }
        }
    }
}
