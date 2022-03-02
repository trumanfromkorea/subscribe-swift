//
//  ModifyItemView.swift
//  subscribe
//
//  Created by 장재훈 on 2022/03/02.
//

import SwiftUI

struct ModifyItemView: View {
    
    @EnvironmentObject var createItem: CreateItemManager
    @EnvironmentObject var subscriptionListManager: SubscriptionListManager
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ModifyItemView_Previews: PreviewProvider {
    static var previews: some View {
        ModifyItemView()
    }
}
