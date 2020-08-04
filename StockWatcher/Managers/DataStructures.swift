//
//  DataStructures.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/30/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation


struct StockResponse: Codable, Equatable, Identifiable  {
    var id = UUID()
    var symbol: String
    var companyName:String
    var primaryExchange:String
    var calculationPrice:String

    var latestPrice:Double
    var previousClose:Double
    
    #if DEBUG
    static let example = StockResponse(id: UUID(), symbol: "aapl", companyName:"apple", primaryExchange:"",calculationPrice:"3",latestPrice:400,previousClose:390)
    #endif
}

