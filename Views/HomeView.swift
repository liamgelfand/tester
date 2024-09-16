import SwiftUI

struct HomeView: View {
    @State private var description: String = "Fetching..."
    @State private var difficulty: Int? = nil

    var body: some View {
        VStack(spacing: 10) { // Reduce spacing to move elements up
            TitleView(title: "WATO")
            
            // Adjust the padding of MessageView if needed
            MessageView(description: description, difficulty: difficulty ?? 0)
                .padding(.top, 20) // Adjust the top padding if needed
            
            ChallengeButton(fetchAction: fetchChallenge)
                .padding(.bottom, 20) // Adjust the bottom padding if needed
        }
        .padding()
        .background(Color.clear)
        .cornerRadius(12)
        .shadow(radius: 10)
        .onAppear {
            fetchChallenge()
        }
    }
    
    private func fetchChallenge() {
        NetworkManager.shared.fetchChallenge { fetchedDescription, fetchedDifficulty in
            DispatchQueue.main.async {
                self.description = fetchedDescription ?? "No description available"
                self.difficulty = fetchedDifficulty
            }
        }
    }
}
