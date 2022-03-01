//
//  BottomSheetView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import SwiftUI

struct BottomSheetView: View {
    @EnvironmentObject var createItem: CreateItemManager

    @Binding var navigateToCreateView: Bool
    @Binding var showBottomSheet: Bool

    @GestureState var gestureOffset: CGFloat = 0

    var body: some View {
            ZStack {
                
                Color.white.cornerRadius(40, corners: [.topLeft, .topRight])

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
                            showBottomSheet = false
                        }) {
                            Text("닫기")
                        }.frame(width: 45)

                    }.padding(.top)

                    Text("지출 등록하기")
                        .font(.system(size: 25, weight: .bold))
                        .padding(.top, 15)

                    Spacer().frame(height: 25)

                    BottomSheetItemView(title: "🧮 구독 서비스 등록하기")
                        .onTapGesture {
                            createItem.setService()
                            navigateToCreateView = true
                            showBottomSheet = false
                        }

                    BottomSheetItemView(title: "🛋 생활비 등록하기")
                        .onTapGesture {
                            createItem.setLiving()
                            navigateToCreateView = true
                            showBottomSheet = false
                        }

                    BottomSheetItemView(title: "🎸 기타 지출 등록하기")
                        .onTapGesture {
                            createItem.setETC()
                            navigateToCreateView = true
                            showBottomSheet = false
                        }
                    
                    Spacer().frame(height: 50)
                }
                .padding(.horizontal, 20)
            }
            .fixedSize(horizontal: false, vertical: true)
    }
}
