//
//  ModifyProfileView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/03/02.
//

import FirebaseAuth
import FirebaseFirestore
import SwiftUI

struct ModifyProfileView: View {
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var userInfoManager: UserInfoManager
    @EnvironmentObject var subscriptionManager: SubscriptionListManager

    @State var userName: String?
    @State var userBirthday: Date?
    @State var genderSelection: Int?

    init() {
//        _userName = State(initialValue: userInfoManager.userName)
//        _userBirthday = State(initialValue: userInfoManager.userBirthday)
//        _genderSelection = State(initialValue: userInfoManager.userGender)
    }

    var body: some View {
        VStack {
            Text("프로필 변경 화면")
            
            Text(userName ?? "")
            Text("\(userBirthday ?? Date())")
            Text("\(genderSelection ?? -1)")
        }.onAppear {
            userName = userInfoManager.userName
            userBirthday = userInfoManager.userBirthday
            genderSelection = userInfoManager.userGender
        }
    }
}

struct ModifyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyProfileView()
    }
}
