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

