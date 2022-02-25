//
//  ProfileMenuItem.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/25.
//

import Foundation
import SwiftUI

struct ProfileMenuItem: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .bold()

            Spacer()

            Image(systemName: "chevron.right")
        }
        .background(.white)
        .padding(EdgeInsets(top: 7, leading: 10, bottom: 7, trailing: 10))
    }
}
