//
//  DataStructures.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/30/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation
struct SingleStockData: Codable {
    var data: Stock?
}


struct Stock: Codable {
    var symbol: String
    var companyName:String
    var latestPrice:Double
    }
