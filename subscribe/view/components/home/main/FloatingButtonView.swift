//
//  FloatingButtonView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import SwiftUI

struct FloatingButtonView: View {
    
    @State var showMenuItem: Bool = false
    @Binding var offset: CGFloat
    @Binding var lastOffset: CGFloat
    
    func showMenu() {
        
        withAnimation{
            offset = -500
            lastOffset = offset
        }
        
    }
    
    var body: some View {
        
            Button(action: {
//                showMenu()
                showMenuItem = true
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.blue)
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            }.sheet(isPresented: self.$showMenuItem) {
                BottomModalView()
            }
        
    }
}

struct FloatingMenuItem: View {
    
    var icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Color.blue)
                .frame(width: 30, height: 30)
            Image(systemName: icon)
                .imageScale(.large)
                .foregroundColor(.white)
        }
        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
    }
}
