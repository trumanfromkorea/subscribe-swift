//
//  FloatingButtonView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import SwiftUI

struct FloatingButtonView: View {
    
    @Binding var showMenuItem: Bool
    
    var body: some View {
        
            Button(action: {
                showMenuItem = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.blue)
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            }
    }
}
