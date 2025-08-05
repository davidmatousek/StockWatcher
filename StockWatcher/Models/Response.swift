//
//  Response.swift
//  StockWatcher
//
//  Updated for Alpha Vantage API - simplified structure
//

import Foundation

struct Response: Codable {
    var stock: [Stock]

    init(stock: [Stock]) {
        self.stock = stock
    }
    
    #if DEBUG
    static let `default` = Response(stock: [])
    #endif
}
