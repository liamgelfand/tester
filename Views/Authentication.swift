import SwiftUI
import AuthenticationServices

struct SignInWithAppleButtonView: View {
    @EnvironmentObject var authManager: AuthManager

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

            // Perform backend login or registration
            loginUserToBackend(userIdentifier: userIdentifier, email: email, fullName: fullName)
        }
    }

    private func loginUserToBackend(userIdentifier: String, email: String?, fullName: String?) {
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
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Error encoding JSON: \(error)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making request: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error or unexpected response")
                return
            }
            
            // Handle successful login/registration
            DispatchQueue.main.async {
                authManager.loginUser(userIdentifier: userIdentifier, email: email, fullName: fullName)
            }
        }
        
        task.resume()
    }
}
