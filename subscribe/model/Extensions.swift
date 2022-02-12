//
//  View_extension.swift
//  subscribe
//
//  Created by 장재훈 on 2022/02/11.
//

import Foundation
import SwiftUI

// 키보드 닫기를 위함
extension UIApplication {

    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }

        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))

        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        tapGesture.name = "MyTapGesture"
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}

// 16 진수 색상을 위함
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

