//
//  StockList.swift
//  StockWatcher
//
//  Updated for Alpha Vantage API
//

import Foundation
import Combine
import SwiftUI

// Temporary Configuration inline until Configuration.swift can be added to Xcode project
enum Configuration {
    enum APIKeyResult {
        case success(String)
        case missingKey
        case testEnvironment
    }
    
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
    
    static let alphaVantageBaseURL = "https://www.alphavantage.co/query"
}

// Temporary StockError until we can add the separate StockError.swift file to the Xcode project
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
}

class StockList: ObservableObject {
    @Published var stockList = Response(stock: [])
    @Published var isLoadingStocks = false
    @Published var errorMessage: String?
    @Published var hasError = false
    @ObservedObject var watchList = WatchList()
    @ObservedObject var rest = RESTManager()
    
    init() {
        
    }
    
    func add(stock: Quote) {
        
    }
    
    func remove(stock: Quote) {
        
    }
    
    func removeAll() {
        
    }
    
    private func handleError(_ error: StockError) {
        DispatchQueue.main.async {
            self.isLoadingStocks = false
            self.hasError = true
            self.errorMessage = error.localizedDescription
        }
    }
    
    func refreshStockList(prod environment: Bool) {
        isLoadingStocks = true
        hasError = false
        errorMessage = nil
        
        // Use the new graceful API key handling
        let apiKeyResult = Configuration.getAPIKey()
        let apiKey: String
        
        switch apiKeyResult {
        case .success(let key):
            apiKey = key
        case .testEnvironment:
            apiKey = "TESTING_PLACEHOLDER_KEY"
            // In test environment, don't make real API calls
            if !environment {
                // Return mock data for testing
                let mockStocks = ["AAPL", "MSFT", "NFLX", "GOOGL", "AMZN"].map { symbol in
                    Stock(symbol: symbol, quote: Quote.default)
                }
                DispatchQueue.main.async {
                    self.stockList = Response(stock: mockStocks)
                    self.isLoadingStocks = false
                }
                return
            }
        case .missingKey:
            handleError(.apiKeyMissing)
            return
        }
        
        // List of stocks to fetch
        let symbols = ["AAPL", "MSFT", "NFLX", "GOOGL", "AMZN"]
        var fetchedStocks: [Stock] = []
        let dispatchGroup = DispatchGroup()
        
        // Fetch each stock individually (Alpha Vantage doesn't support batch requests on free tier)
        for symbol in symbols {
            dispatchGroup.enter()
            let urlString = "\(Configuration.alphaVantageBaseURL)?function=GLOBAL_QUOTE&symbol=\(symbol)&apikey=\(apiKey)"
            
            guard let url = URL(string: urlString) else { 
                dispatchGroup.leave()
                continue 
            }
            
            rest.fetch(url, defaultValue: AlphaVantageResponse(globalQuote: Quote.default)) { response in
                let stock = Stock(symbol: response.globalQuote.symbol, quote: response.globalQuote)
                fetchedStocks.append(stock)
                dispatchGroup.leave()
            }
        }
        
        // Update UI when all stocks are fetched
        dispatchGroup.notify(queue: .main) {
            if fetchedStocks.isEmpty {
                self.handleError(.networkFailure)
            } else {
                self.stockList = Response(stock: fetchedStocks.sorted { 
                    ($0.symbol ?? "") < ($1.symbol ?? "")
                })
                self.isLoadingStocks = false
            }
        }
    }
}