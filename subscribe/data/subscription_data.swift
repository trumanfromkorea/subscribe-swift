//
//  subscription_data.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/12.
//

import Foundation

struct SubscriptionInfo: Hashable {
    var id: String
    var category: String
    var title: String
    var fee: String
    var startDate: Date
    var nextDate: Date
    var cycleType: Int
    var cycleValue: String
    var isLastDate: Bool

    enum SubscriptionInfoKeys: String, CodingKey {
        case id
        case category
        case title
        case fee
        case startDate
        case nextDate
        case cycleType
        case cycleValue
        case isLastDate
    }
}


