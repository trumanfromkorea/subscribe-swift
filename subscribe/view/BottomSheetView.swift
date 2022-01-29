//
//  BottomSheetView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import SwiftUI

struct BottomSheetView: View {
    @Binding var offset: CGFloat
    @Binding var lastOffset: CGFloat
    @GestureState var gestureOffset: CGFloat = 0

    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }

    var body: some View {
        GeometryReader { proxy -> AnyView in
            let height = proxy.frame(in: .global).height

            return AnyView(
                ZStack(alignment: .top) {
                    Color.white

                    // Bottom Sheet Controller Bar
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 60, height: 4)
                        .padding(.top)
                }
                .clipShape(CustomCorner(corners: [.topLeft, .topRight], radius: 30))
                .offset(y: height)
                .offset(
                    y: -offset > 0
                        ? -offset <= height
                        ? offset : -height : 0 // overflow 방지
                )
                .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                    out = value.translation.height
                    onChange()
                }).onEnded({ _ in
                    let maxHeight = height

                    withAnimation {
                        // logic for moving states
                        if -offset > maxHeight / 4 * 3 {
                            offset = -maxHeight
                        } else {
                            offset = 0
                        }

                        // storing last offset
                        lastOffset = offset
                    }
                }))
            )
        }
    }
}
