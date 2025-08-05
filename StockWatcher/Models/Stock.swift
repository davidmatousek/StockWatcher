//
//  Stock.swift
//  StockWatcher
//
//  Created by Matousek, David on 9/19/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation

struct Stock: Codable {
    var symbol: String?
    let quote: Quote
    // Simplified for Alpha Vantage - we'll fetch news and charts separately if needed
    
    init(symbol: String?, quote: Quote) {
        self.symbol = symbol
        self.quote = quote
    }
    
    #if DEBUG
    static let `default` = Stock(
        symbol: "AAPL",
        quote: Quote.default
    )
    #endif
}

