//
//  ContentView.swift
//  Example
//
//  Created by Alisa Mylnikova on 23/04/2020.
//  Copyright © 2020 Exyte. All rights reserved.
//

import ExytePopupView
import SwiftUI

struct TestView: View {
    @State var showPopup = false

    var body: some View {
        VStack {
            Text("testing popupview package")
            Button {
                showPopup.toggle()
            } label: {
                Text("lets go")
            }

        }.popup(isPresented: $showPopup, animation: .spring(), closeOnTapOutside: true, backgroundColor: .black.opacity(0.5)) {
            VStack {
                Text("this is a sample Popup View")
                    .foregroundColor(.white)
                Button {
                    showPopup = false
                } label: {
                    Text("toggle please")
                }
            }
            .padding()
            .background(.black)
            .cornerRadius(10)
        }
    }
}
