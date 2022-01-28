//
//  HomeView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(hex: 0xF7F7F7).ignoresSafeArea()
            ScrollView {
                Text("장재훈 님의 구독")
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 10) {
                    Text("이번 달 지출 총액").foregroundColor(Color.black)
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("결제 완료").foregroundColor(Color.black)
                            Text("99,000 원").foregroundColor(Color.black)
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 5) {
                            Text("지출 총액").foregroundColor(Color.black)
                            Text("108,990 원").foregroundColor(Color.black)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: 0xFFFFFF))
                .cornerRadius(10)

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
            .navigationBarTitle(Text("구독 모아보기"), displayMode: .inline)
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
