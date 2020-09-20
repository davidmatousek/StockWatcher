//
//  Chart.swift
//  StockWatcher
//
//  Created by Matousek, David on 9/19/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation

struct Chart: Codable {
    var date: String?
    var chartOpen, close, high, low: Double?
    var volume: Int?
    var uOpen, uClose, uHigh, uLow: Double?
    var uVolume: Int?
    var change, changePercent: Double?
    var label: String?
    var changeOverTime: Double?
}
