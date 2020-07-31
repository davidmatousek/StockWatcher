//
//  DataStructures.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/30/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation


struct StockResponse: Codable {
    var symbol: String
    var companyName:String
    var primaryExchange:String
    var calculationPrice:String

    var latestPrice:Double
    var previousClose:Double
}

