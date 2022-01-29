//
//  HomeView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import PartialSheet
import SwiftUI

struct HomeView: View {
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @GestureState var gestureOffset: CGFloat = 0

    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
    }

    func getBlurRadius() -> CGFloat {
        let progress = -offset / (UIScreen.main.bounds.height - 100)

        return progress * 30
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(hex: 0xF7F7F7).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                Spacer().frame(height: 20)

                Text("장재훈 님의 구독 모아보기")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 23))

                TotalCostView()

                ForEach(0 ..< 10) { _ in
                    Spacer().frame(height: 10)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("NETFLIX").foregroundColor(Color.black)

                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("결제 금액").foregroundColor(Color.black)
                                Text("10,000 원").foregroundColor(Color.black)
                            }

                            Spacer()

                            VStack(alignment: .leading, spacing: 5) {
                                Text("결제일").foregroundColor(Color.black)
                                Text("12.03 (목)").foregroundColor(Color.black)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: 0xFFFFFF))
                    .cornerRadius(10)
                }
            }
            .disabled(offset != 0) // bottom sheet 올라와있으면 스크롤 금지
            .blur(radius: getBlurRadius()) // bottom sheet 올라올때 블러
            .navigationBarTitle(Text("구독 모아보기"), displayMode: .inline)
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            // Binding 으로 State 를 넘겨줘서 자식 -> 부모 값 전달가능
            FloatingButtonView(offset: $offset, lastOffset: $lastOffset)
                .padding()

            // Bottom Sheet
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height

                return AnyView(
                    ZStack(alignment: .top) {
                        Color(hex: 0xFFFFFF)

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
                            ? -offset <= height - 100
                            ? offset : -(height - 100) : 0 // overflow 방지
                    )
                    .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                        out = value.translation.height
                        onChange()
                    }).onEnded({ _ in
                        let maxHeight = height
                        
                        withAnimation {
                            // logic for moving states
                            if -offset > 100 && -offset < maxHeight / 2 {
                                offset = -(maxHeight / 3)
                            } else if -offset > maxHeight / 2 {
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
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
