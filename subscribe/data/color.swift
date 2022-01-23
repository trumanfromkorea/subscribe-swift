//
//  color.swift
//  subscribe
//
//  Created by 장재훈 on 2022/01/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 08) & 0xFF) / 255,
            blue: Double((hex >> 00) & 0xFF) / 255,
            opacity: alpha
        )
    }

    init(_ _red: Double, _ _green: Double, _ _blue: Double) {
        self.init(
            red: _red / 255,
            green: _green / 255,
            blue: _blue / 255,
            opacity: 1
        )
    }
}
