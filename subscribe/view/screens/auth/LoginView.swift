//
//  LoginView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct LoginView: View {

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()

            VStack {
                Spacer()

                Image("textLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)

                Spacer()

                AppleLoginButton()
                
                Spacer().frame(height: 20)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
