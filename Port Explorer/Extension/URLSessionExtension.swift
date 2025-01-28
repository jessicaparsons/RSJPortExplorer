//
//  URLSessionExtension.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/18/25.
//

import Foundation


extension URLSession {
    
    
    func fetchAndDecode<T: Decodable>(
        from url: URL,
        headers: [String: String] = [:],
        as type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }

        // Fetch data
        let task = self.dataTask(with: request) { data, response, error in
            // Handle errors
            if let error = error {
                completion(.failure(error))
                return
            }

            // Decode JSON
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: -1, userInfo: nil)))
                return
            }

            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
