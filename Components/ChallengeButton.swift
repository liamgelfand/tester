import SwiftUI
import Foundation

struct ChallengeButton: View {
    var fetchAction: () -> Void
    
    var body: some View {
        Button(action: fetchAction) {
            Text("Get a challenge")
                .padding()
                .font(.title2)
        }
        .background(Color(hex: "#F5F5DC"))
        .foregroundColor(.red)
        .cornerRadius(8)
    }
}

struct ChallengeButton_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeButton {
            print("Button tapped")
        }
        .previewLayout(.sizeThatFits)
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
