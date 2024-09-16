import SwiftUI
import AuthenticationServices

struct SignInView: View {
    var body: some View {
        SignInWithAppleButton(
            .signIn,
            onRequest: configureRequest,
            onCompletion: handleCompletion
        )
        .signInWithAppleButtonStyle(.black)
        .frame(height: 44)
        .padding()
    }

    private func configureRequest(_ request: ASAuthorizationAppleIDRequest) {
        request.requestedScopes = [.fullName, .email]
    }

    private func handleCompletion(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let authorization):
            handleAuthorization(authorization)
        case .failure(let error):
            print("Error during authorization: \(error)")
        }
    }

    private func handleAuthorization(_ authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let email = appleIDCredential.email
            let fullName = appleIDCredential.fullName?.givenName

            // Save userIdentifier, email, and fullName as needed
            // Send to your backend server for login or registration

            // Example: Save userIdentifier for future use
            UserDefaults.standard.set(userIdentifier, forKey: "userIdentifier")

            // Example: Perform backend login request here
            loginUserToBackend(userIdentifier: userIdentifier, email: email, fullName: fullName)
        }
    }

    private func loginUserToBackend(userIdentifier: String, email: String?, fullName: String?) {
        // Ensure the correct URL for your backend
        guard let url = URL(string: "http://localhost:8000/users/authenticate") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "apple_id": userIdentifier,
            "email": email ?? "",
            "name": fullName ?? ""
        ]

        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            guard let data = data,
                  let response = try? JSONDecoder().decode([String: String].self, from: data) else {
                print("Failed to decode response")
                return
            }

            print("Response: \(response)")
        }

        task.resume()
    }
}
