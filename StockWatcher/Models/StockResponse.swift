//
//  StockResponse.swift
//  StockWatcher
//
//  Created by Matousek, David on 8/6/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation

struct StockResponse: Codable, Equatable, Identifiable  {
    var id = UUID()
    let symbol: String
    let companyName: String
    let primaryExchange: String
//    let calculationPrice: String
//    let welcomeOpen, openTime: NSNull
//    let openSource: String
//    let close, closeTime: NSNull
//    let closeSource: String
//    let high: NSNull
//    let highTime: Int
//    let highSource: String
//    let low: NSNull
//    let lowTime: Int
//    let lowSource: String
//    let latestPrice: Double
//    let latestSource, latestTime: String
//    let latestUpdate: Int
//    let latestVolume: NSNull
//    let iexRealtimePrice: Double
//    let iexRealtimeSize, iexLastUpdated: Int
//    let delayedPrice, delayedPriceTime, oddLotDelayedPrice, oddLotDelayedPriceTime: NSNull
//    let extendedPrice, extendedChange, extendedChangePercent, extendedPriceTime: NSNull
//    let previousClose, previousVolume: Int
//    let change, changePercent: Double
//    let volume: NSNull
//    let iexMarketPercent: Double
//    let iexVolume, avgTotalVolume: Int
//    let iexBidPrice: Double
//    let iexBidSize, iexAskPrice, iexAskSize: Int
//    let iexOpen, iexOpenTime: NSNull
//    let iexClose: Double
//    let iexCloseTime, marketCap: Int
//    let peRatio, week52High, week52Low, ytdChange: Double
//    let lastTradeTime: Int
//    let isUSMarketOpen: Bool
    //var calculationPrice:String

    
   // var latestPrice:Double
    //var previousClose:Double
    
    #if DEBUG
    //static let example = StockResponse(id: UUID(), symbol: "aapl", companyName:"apple", primaryExchange:"",calculationPrice:"3",latestPrice:400,previousClose:390)
    //static let `default` = StockResponse(id: UUID(), symbol: "aapl", companyName:"apple", primaryExchange:"",calculationPrice:"3",latestPrice:400,previousClose:390)
    static let `default` = StockResponse(id: UUID(), symbol: "error", companyName:"error", primaryExchange:"")
    #endif
}


/*
 {"symbol":"AAPL","companyName":"Apple, Inc.","primaryExchange":"QSAAND","calculationPrice":"tops","open":null,"openTime":null,"openSource":"icfoifla","close":null,"closeTime":null,"closeSource":"oafflici","high":null,"highTime":1609817951939,"highSource":"dmpe5 y1euicaeit lend r","low":null,"lowTime":1602767477025,"lowSource":"dceeriymted aue1p n 5il","latestPrice":132.54,"latestSource":"IEX real time price","latestTime":"10:11:28 AM","latestUpdate":1649992503117,"latestVolume":null,"iexRealtimePrice":131.51,"iexRealtimeSize":105,"iexLastUpdated":1662410599206,"delayedPrice":null,"delayedPriceTime":null,"oddLotDelayedPrice":null,"oddLotDelayedPriceTime":null,"extendedPrice":null,"extendedChange":null,"extendedChangePercent":null,"extendedPriceTime":null,"previousClose":135,"previousVolume":200670860,"change":-4.52,"changePercent":-0.0343,"volume":null,"iexMarketPercent":0.015528995571654904,"iexVolume":610080,"avgTotalVolume":196273033,"iexBidPrice":129.7,"iexBidSize":105,"iexAskPrice":133,"iexAskSize":101,"iexOpen":null,"iexOpenTime":null,"iexClose":127.67,"iexCloseTime":1620057026390,"marketCap":2237566735252,"peRatio":39.5,"week52High":142.82,"week52Low":51.52,"ytdChange":0.724483,"lastTradeTime":1605389815420,"isUSMarketOpen":true}
 */
