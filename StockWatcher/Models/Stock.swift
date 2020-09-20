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
    let news: [News]?
    let quote: Quote
    let chart: [Chart]?
    
    #if DEBUG

    static let `default` = Stock(
                                 symbol: "",
                                news: [],
                                quote: Quote.default,
                                chart: []
                                )
    #endif
    
}

