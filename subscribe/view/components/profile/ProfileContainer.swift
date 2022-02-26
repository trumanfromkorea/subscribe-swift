//
//  ProfileContainer.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/26.
//

import SwiftUI

struct ProfileContainer: View {
    var userName: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 55, height: 55)
                .foregroundColor(Color(hex: 0xD1D1D1))

            Spacer().frame(width: 10)

            VStack(alignment: .leading) {
                Text(userName)
                    .font(.system(size: 20))
                    .bold()

                Spacer().frame(height: 5)

                Text("프로필 편집")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10))
        .background(.white)
    }
}
