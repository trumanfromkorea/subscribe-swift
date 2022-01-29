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

    // http request sample code
    @State private var user: User?

    func getBlurRadius() -> CGFloat {
        withAnimation { let progress = -offset / (UIScreen.main.bounds.height - 100)

            return progress * 30
        }
    }

    func requestData() {
        guard let url = URL(string: "https://api.github.com/users/trumanfromkorea")
        else {
            print("유효한 url 이 아닙니다")
            return
        }

        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data,
               let decodedData = try? JSONDecoder().decode(User.self, from: data) {
                self.user = decodedData
                return
            }
            print(error?.localizedDescription ?? "ERROR")
        }.resume()
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(hex: 0xF7F7F7).ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                Spacer().frame(height: 20)

                Text("\(user?.name ?? "") 님의 구독 모아보기")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(.system(size: 23, weight: .bold))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 0))


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
            .blur(radius: getBlurRadius()) // bottom sheet 올라올때 blur
            .navigationBarTitle(Text("구독 모아보기"), displayMode: .inline)
            .padding(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            Color(hex: 0x000000, alpha: offset == 0 ? 0 : 0.5).ignoresSafeArea()

            // Binding 으로 State 를 넘겨줘서 자식 -> 부모 값 전달가능
            FloatingButtonView(offset: $offset, lastOffset: $lastOffset)
                .padding()

            // Bottom Sheet
            BottomSheetView(offset: $offset, lastOffset: $lastOffset)
        }
        .onAppear(perform: requestData)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
