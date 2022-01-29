//
//  BlurView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
      
    }
    
}

