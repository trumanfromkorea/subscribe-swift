//
//  LoadingView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        
        ZStack{
            Color.black.opacity(0.5).ignoresSafeArea()
            
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
        }
     
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
