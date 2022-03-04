//
//  UI_model.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/21.
//

import Foundation

class UIManager: ObservableObject {
    @Published var isLoading : Bool = false
    @Published var navigationBarHidden: Bool = true
    
    func setLoadingTrue () {
        self.isLoading = true
    }
    
    func setLoadingFalse() {
        self.isLoading = false
    }
    
    func setNavigationBarHidden() {
        self.navigationBarHidden = true
    }
    
    func setNavigationBarVisible() {
        self.navigationBarHidden = false
    }
}
