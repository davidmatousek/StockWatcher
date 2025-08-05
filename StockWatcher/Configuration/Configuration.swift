//
//  Configuration.swift
//  StockWatcher
//
//  Created by Claude on 8/4/25.
//  Copyright © 2025 David Matousek. All rights reserved.
//

import Foundation

enum Configuration {
    
    /// Alpha Vantage API Key from environment variables or bundle
    static var alphaVantageAPIKey: String {
        // First try environment variable (for CI/CD and development)
        if let envKey = ProcessInfo.processInfo.environment["ALPHA_VANTAGE_API_KEY"] {
            return envKey
        }
        
        // Fallback to Info.plist (for local development - not committed)
        guard let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
              let plist = NSDictionary(contentsOfFile: path),
              let key = plist["AlphaVantageAPIKey"] as? String,
              !key.isEmpty else {
            fatalError("""
                Alpha Vantage API Key not found!
                
                Please set up your API key using one of these methods:
                1. Set environment variable: ALPHA_VANTAGE_API_KEY
                2. Add your key to StockWatcher/Property Files/Keys.plist
                
                Get a free API key at: https://www.alphavantage.co/support/#api-key
                """)
        }
        
        return key
    }
    
    /// Base URL for Alpha Vantage API
    static let alphaVantageBaseURL = "https://www.alphavantage.co/query"
    
    /// API rate limits
    static let apiCallsPerMinute = 5
    static let apiCallsPerDay = 25
}