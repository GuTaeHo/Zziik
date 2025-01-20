//
//  Color+.swift
//  Zziik
//
//  Created by 구태호 on 1/20/25.
//

import SwiftUI


extension Color {
    init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: red.clamped(to: 0.0...1.0),
            green: green.clamped(to: 0.0...1.0),
            blue: blue.clamped(to: 0.0...1.0),
            opacity: alpha.clamped(to: 0.0...1.0)
        )
    }
    
    /// Convenience initializer for creating a Color from a HEX string.
    /// - Parameters:
    ///   - hex: A HEX color string (e.g., "#FF5733", "FF5733", or "FFF").
    ///   - alpha: Optional alpha value (0.0 - 1.0). If not provided, defaults to 1.0.
    init(hex: String, alpha: Double = 1.0) {
        let sanitizedHex = hex
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        
        var rgbValue: UInt64 = 0
        Scanner(string: sanitizedHex).scanHexInt64(&rgbValue)
        
        let length = sanitizedHex.count
        let red, green, blue: Double
        
        switch length {
        case 6: // HEX format: RRGGBB
            red = Double((rgbValue >> 16) & 0xFF) / 255.0
            green = Double((rgbValue >> 8) & 0xFF) / 255.0
            blue = Double(rgbValue & 0xFF) / 255.0
        case 3: // HEX format: RGB (shorthand)
            red = Double((rgbValue >> 8) & 0xF) / 15.0
            green = Double((rgbValue >> 4) & 0xF) / 15.0
            blue = Double(rgbValue & 0xF) / 15.0
        default:
            // Invalid HEX format
            red = 0
            green = 0
            blue = 0
        }
        
        self.init(
            .sRGB,
            red: red.clamped(to: 0.0...1.0),
            green: green.clamped(to: 0.0...1.0),
            blue: blue.clamped(to: 0.0...1.0),
            opacity: alpha.clamped(to: 0.0...1.0)
        )
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}
