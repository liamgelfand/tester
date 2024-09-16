import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseURL = "http://127.0.0.1:8000" // Replace with your actual IP address and port
    
    // Fetch the challenge from the backend API
    func fetchChallenge(completion: @escaping (String?, Int?) -> Void) {
        guard let url = URL(string: "\(baseURL)/challenge") else {
            completion(nil, nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(nil, nil)
                return
            }
            
            guard let data = data else {
                completion(nil, nil)
                return
            }
            
            do {
                // Decode the JSON response into the Challenge model
                let challengeResponse = try JSONDecoder().decode([String: Challenge].self, from: data)
                
                if let challenge = challengeResponse["challenge"] {
                    // Extract the description and difficulty
                    let description = challenge.description
                    let difficulty = challenge.difficulty
                    completion(description, difficulty)
                } else {
                    completion(nil, nil)
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil, nil)
            }
        }
        
        task.resume()
    }
}
