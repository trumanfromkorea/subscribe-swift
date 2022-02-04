//
//  bottomSheetItem_view.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import SwiftUI

struct BottomSheetItemView: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 18))
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
        .background(Color.white)

        Divider()
    }
}
