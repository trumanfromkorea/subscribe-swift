//
//  AgreePolicy.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/26.
//

import SwiftUI

struct AgreePolicy: View {
    @Binding var agreeAll: Bool
    @Binding var agree_01: Bool
    @Binding var agree_02: Bool
    @Binding var agree_03: Bool
    
    func handleCheckbox(_ flag: Bool) {
        if !flag {
            agreeAll = false
        }
        
        if agree_01 && agree_02 && agree_03 {
            agreeAll = true
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Image(systemName: agreeAll ? "checkmark.square.fill" : "square")
                    .foregroundColor(agreeAll ? .blue : .black)
                Text("전체 동의")
                    .font(.system(size: 18))
            }
            .onTapGesture {
                agreeAll.toggle()

                agree_01 = agreeAll
                agree_02 = agreeAll
                agree_03 = agreeAll
            }

            Divider()

            CheckboxView(flag: agree_01, label: "이용약관 동의")
                .onTapGesture {
                    agree_01.toggle()
                    handleCheckbox(agree_01)
                }
            
            Spacer().frame(height: 5)
            
            CheckboxView(flag: agree_02, label: "개인정보 제공 동의")
                .onTapGesture {
                    agree_02.toggle()
                    handleCheckbox(agree_02)
                }
            
            Spacer().frame(height: 5)
            
            CheckboxView(flag: agree_03, label: "알림 수신 동의 (선택)")
                .onTapGesture {
                    agree_03.toggle()
                    handleCheckbox(agree_03)
                }
        }
    }
}

struct CheckboxView: View {

    var flag: Bool
    var label: String
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: flag ? "checkmark.square.fill" : "square")
                .foregroundColor(flag ? .blue.opacity(0.5) : .black)
            Text(label)
                .font(.system(size: 16))
                .foregroundColor(Color(hex: 0x404040))
        }
    }
}
