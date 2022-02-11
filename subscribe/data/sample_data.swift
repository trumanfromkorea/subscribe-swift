//
//  sampleData.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/29.
//

import Foundation

struct User: Codable {
    let name: String
    let accountName: String
    let avatarURL: String
    let followers: Int
    let following: Int

    enum CodingKeys: String, CodingKey {
        case name
        case accountName = "login"
        case avatarURL = "avatar_url"
        case followers
        case following
    }
}

struct SubscriptionInfo: Hashable {
    var id: String
    var category: String
    var title: String
    var fee: String
    var startDate: Date
    var nextDate: Date
    var cycle: Int
    var cycleNum: Int

//    init(
//        id: String,
//        category: String,
//        title: String,
//        fee: String,
//        startDate: Date,
//        nextDate: Date,
//        cycle: Int,
//        cycleNum: Int
//    ) {
//        self.id = id
//        self.category = category
//        self.title = title
//        self.fee = fee
//        self.startDate = startDate
//        self.nextDate = nextDate
//        self.cycle = cycle
//        self.cycleNum = cycleNum
//    }

    enum SubscriptionInfoKeys: String, CodingKey {
        case id
        case category
        case title
        case fee
        case startDate
        case nextDate
        case cycle
        case cycleNum
    }
}
