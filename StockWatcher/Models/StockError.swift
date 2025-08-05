//
//  StockError.swift
//  StockWatcher
//
//  Created by Claude on 8/4/25.
//  Copyright © 2025 David Matousek. All rights reserved.
//

import Foundation

enum StockError: Error, LocalizedError {
    case networkFailure
    case invalidData
    case apiKeyMissing
    case rateLimitExceeded
    case invalidSymbol(String)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .networkFailure:
            return "Unable to connect to the stock data service. Please check your internet connection."
        case .invalidData:
            return "The stock data received was invalid or corrupted."
        case .apiKeyMissing:
            return "API key is missing or invalid. Please check your configuration."
        case .rateLimitExceeded:
            return "API rate limit exceeded. Please wait a moment before refreshing."
        case .invalidSymbol(let symbol):
            return "Invalid stock symbol: \(symbol)"
        case .unknown(let error):
            return "An unexpected error occurred: \(error.localizedDescription)"
        }
    }
    
    var recoveryDescription: String? {
        switch self {
        case .networkFailure:
            return "Check your internet connection and try again."
        case .invalidData:
            return "Try refreshing the data."
        case .apiKeyMissing:
            return "Contact support or check your API key configuration."
        case .rateLimitExceeded:
            return "Alpha Vantage free tier allows 5 calls per minute. Please wait."
        case .invalidSymbol:
            return "Please verify the stock symbol is correct."
        case .unknown:
            return "Try again later or contact support if the problem persists."
        }
    }
}