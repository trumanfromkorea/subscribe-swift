//
//  FloatingButtonView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import SwiftUI

struct FloatingButtonView: View {
    
    @State var showMenuItem: Bool = false
    
    func showMenu() {
        showMenuItem.toggle()
    }
    
    var body: some View {
        VStack {
            
            Spacer()
            
            if showMenuItem {
                FloatingMenuItem(icon: "camera.fill")
                FloatingMenuItem(icon: "photo.on.rectangle")
                FloatingMenuItem(icon: "square.and.arrow.up.fill")
            }
            
            Button(action: {
                showMenu()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.blue)
                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
            }
            
            
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
