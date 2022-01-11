//
//  UserAuth.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/11.
//

import Foundation
import Combine

class UserAuth: ObservableObject {
    @Published var isSignedIn: Bool = false
    
    func signIn(){
        self.isSignedIn = true
    }
}
