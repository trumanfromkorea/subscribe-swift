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
            Color(hex: 0xFFFFFF).ignoresSafeArea()
            ScrollView {
                Text("장재훈 님의 구독")
                    .frame(maxWidth: .infinity, alignment: .leading)

                VStack(alignment: .leading, spacing: 10) {
                    Text("이번 달 지출 총액")
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("결제 완료")
                            Text("99,000 원")
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 5) {
                            Text("지출 총액")
                            Text("108,990 원")
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: 0xF7F7F7))
                .cornerRadius(10)

                ForEach(0 ..< 10) { _ in
                    Spacer().frame(height: 10)
                    VStack(alignment: .leading, spacing: 10) {
                        Text("NETFLIX")
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("결제 금액")
                                Text("10,000 원")
                            }

                            Spacer()

                            VStack(alignment: .leading, spacing: 5) {
                                Text("결제일")
                                Text("12.03 (목)")
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: 0xF7F7F7))
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
