//
//  Configuration.swift
//  StockWatcher
//
//  Created by Claude on 8/4/25.
//  Copyright © 2025 David Matousek. All rights reserved.
//

import Foundation

enum Configuration {
    
    /// Result type for API key retrieval
    enum APIKeyResult {
        case success(String)
        case missingKey
        case testEnvironment
    }
    
    /// Safely retrieve Alpha Vantage API Key from environment variables or bundle
    static func getAPIKey() -> APIKeyResult {
        // For testing environments, return test environment indicator
        if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil {
            return .testEnvironment
        }
        
        // First try environment variable (for CI/CD and development)
        if let envKey = ProcessInfo.processInfo.environment["ALPHA_VANTAGE_API_KEY"] {
            return .success(envKey)
        }
        
        // Fallback to Info.plist (for local development - not committed)
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let key = plist["AlphaVantageAPIKey"] as? String,
              !key.isEmpty else {
            return .missingKey
        }
        
        return .success(key)
    }
    
    /// Legacy property for backwards compatibility - use getAPIKey() for better error handling
    static var alphaVantageAPIKey: String {
        switch getAPIKey() {
        case .success(let key):
            return key
        case .testEnvironment:
            return "TESTING_PLACEHOLDER_KEY"
        case .missingKey:
            return "" // Return empty string instead of crashing
        }
    }
    
    /// Base URL for Alpha Vantage API
    static let alphaVantageBaseURL = "https://www.alphavantage.co/query"
    
    /// API rate limits
    static let apiCallsPerMinute = 5
    static let apiCallsPerDay = 25
}