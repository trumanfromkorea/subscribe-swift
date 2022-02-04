//
//  CreateItemView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/04.
//

import SwiftUI

struct CreateItemView: View {
    // 뒤로가기 위해서
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        self.modifier(
            CustomBackButton(backButtonAction: {
                self.presentationMode.wrappedValue.dismiss()
            })
        )
    }
}

struct CustomBackButton: ViewModifier {
    var backButtonAction: () -> Void

    func body(content: Content) -> some View {
        Button(action: { self.backButtonAction() },
               label: {
                   Image(systemName: "chevron.left")
               })
    }
}

struct CreateItemView_Previews: PreviewProvider {
    static var previews: some View {
        CreateItemView()
    }
}
