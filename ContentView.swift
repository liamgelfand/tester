import SwiftUI

struct ContentView: View {
    @State private var currentPage: Int = 1 // Start at the HomeView, which is tagged with 1

    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color(hex: "#FF5722"), Color(hex: "#FF6F61")]), // Burnt Orange to Coral
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all) // Ensure the gradient covers the entire screen

            // TabView
            TabView(selection: $currentPage) {
                PersonalView() // Page 1
                    .tag(0)
                HomeView() // The new home view
                    .tag(1)
                FriendsView() // Page 2
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

        }
    }
}
