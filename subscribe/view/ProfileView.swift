//
//  ProfileView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userAuth: UserAuth

    var body: some View {
        ZStack {
            Color(hex: 0xFFFFFF).ignoresSafeArea()
            
            VStack {
                Divider()
                
                Button(action: {
                    userAuth.signOut()
                }, label: {
                    Text("로그아웃")
                    
                    Spacer() 

                    Image(systemName: "chevron.right")
                })
                
                Divider()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
