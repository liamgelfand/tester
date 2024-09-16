import Foundation

class AuthManager: ObservableObject {
    @Published var isLoggedIn: Bool = false

    func checkLoginStatus() {
        // Implement logic to check if the user is logged in
        if let _ = UserDefaults.standard.string(forKey: "userIdentifier") {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }

    func loginUser(userIdentifier: String, email: String?, fullName: String?) {
        // Save user information to UserDefaults or another secure place
        UserDefaults.standard.set(userIdentifier, forKey: "userIdentifier")
        // Update the authentication state
        isLoggedIn = true
    }

    func logoutUser() {
        // Clear user information and update authentication state
        UserDefaults.standard.removeObject(forKey: "userIdentifier")
        isLoggedIn = false
    }
}
