//
//  ProfileView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            Text("this is profile view")
                .foregroundColor(Color.white)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
