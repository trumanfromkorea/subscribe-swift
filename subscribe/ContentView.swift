//
//  ContentView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import AuthenticationServices
import SwiftUI

struct ContentView: View {
    var body: some View {
        SignInWithAppleButton(.signIn) { request in
            request.requestedScopes = [.fullName, .email]
        } onCompletion: { result in
//            switch result {
//            case let .success(authResults):
//                print("Authorization successful")
//            case let .error(error):
//                print("FAILED : \(error.localizedDescription)")
//            }
            print(result)
        }.signInWithAppleButtonStyle(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
