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
            let width = proxy.frame(in: .global).width

            return AnyView(
                ZStack(alignment: .top) {
                    Color(hex: 0xF8F8F8)

                    VStack {
                        // Bottom Sheet Controller Bar
                        HStack {
                            Spacer().frame(width: 45)
                            Spacer()

                            Capsule()
                                .fill(Color.gray)
                                .frame(width: 60, height: 4)

                            Spacer()

                            Button(action: {
                                withAnimation{
                                    offset = 0
                                }
                                
                            }) {
                                Text("닫기")
                            }.frame(width: 45)

                        }.padding(.top)

                        Text("지출 등록하기")
                            .font(.system(size: 25, weight: .bold))
                            .frame(width: width - 60, alignment: .leading)
                            .padding(.top)

                        Spacer().frame(height: 25)

                        
                        BottomSheetItemView(title: "📝 구독 서비스 등록하기")
                        BottomSheetItemView(title: "🛍 생활비 등록하기")
                        BottomSheetItemView(title: "🎸 기타 지출 등록하기")
                        
                        Button(action: {
                            
                        }){
                            HStack{
                                Image(systemName: "plus.circle")
                                Text("추가 카테고리 등록하기")
                            }
                        }
                    }
                    .frame(width: .infinity)
                    .padding(EdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30))
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

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetView(offset: .constant(-500), lastOffset: .constant(-500))
    }
}
