import SwiftUI

// Assuming this is the extension in MessageView.swift
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgb: UInt64 = 0

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if Scanner(string: hexColor).scanHexInt64(&rgb) {
                let red = Double((rgb >> 16) & 0xFF) / 255
                let green = Double((rgb >> 8) & 0xFF) / 255
                let blue = Double(rgb & 0xFF) / 255
                self.init(
                    .sRGB,
                    red: red,
                    green: green,
                    blue: blue,
                    opacity: 1.0
                )
                return
            }
        }
        
        // Default color if hex string is invalid
        self.init(.sRGB, red: 1.0, green: 1.0, blue: 1.0, opacity: 1.0)
    }
}

// Define MessageView here
struct MessageView: View {
    var description: String
    var difficulty: Int

    var body: some View {
        VStack {
            Text(description)
                .font(.headline)
            Text("Difficulty: \(difficulty)")
                .font(.subheadline)
        }
        .padding()
        .background(Color(hex: "#F0F0F0")) // Example usage of the Color extension
        .cornerRadius(8)
    }
}
