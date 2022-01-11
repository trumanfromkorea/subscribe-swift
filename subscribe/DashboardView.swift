//
//  DashboardView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        ZStack{
            Color.blue
                .ignoresSafeArea()
            Text("login success")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
