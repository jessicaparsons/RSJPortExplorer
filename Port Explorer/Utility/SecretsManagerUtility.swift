//
//  SecretsManagerUtility.swift
//  Royal Sea Journeys
//
//  Created by Jessica Parsons on 1/24/25.
//

import Foundation

struct SecretsManager {
    static func getAPIKey() -> String? {
        guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dictionary = NSDictionary(contentsOfFile: path) as? [String: Any],
              let apiKey = dictionary["API_KEY"] as? String else {
            return nil
        }
        return apiKey
    }
}
