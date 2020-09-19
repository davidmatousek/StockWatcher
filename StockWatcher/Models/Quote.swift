//
//  StockResponse.swift
//  StockWatcher
//
//  Created by Matousek, David on 8/6/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//
/*
 {"symbol":"AAPL","companyName":"Apple, Inc.","primaryExchange":"NASDAQ","calculationPrice":"close","open":110.41,"openTime":1600435801331,"openSource":"official","close":106.84,"closeTime":1600459201291,"closeSource":"official","high":110.88,"highTime":1600473599055,"highSource":"15 minute delayed price","low":106.09,"lowTime":1600450273472,"lowSource":"15 minute delayed price","latestPrice":106.84,"latestSource":"Close","latestTime":"September 18, 2020","latestUpdate":1600459201291,"latestVolume":287104882,"iexRealtimePrice":null,"iexRealtimeSize":null,"iexLastUpdated":null,"delayedPrice":106.93,"delayedPriceTime":1600473599055,"oddLotDelayedPrice":127.67,"oddLotDelayedPriceTime":1600462729838,"extendedPrice":106.93,"extendedChange":0.09,"extendedChangePercent":0.00084,"extendedPriceTime":1600473599055,"previousClose":110.34,"previousVolume":178010968,"change":-3.5,"changePercent":-0.03172,"volume":287104882,"iexMarketPercent":null,"iexVolume":null,"avgTotalVolume":197471715,"iexBidPrice":null,"iexBidSize":null,"iexAskPrice":null,"iexAskSize":null,"iexOpen":null,"iexOpenTime":null,"iexClose":106.86,"iexCloseTime":1600459196732,"marketCap":1852317132000,"peRatio":32.2,"week52High":137.98,"week52Low":53.15,"ytdChange":0.437766,"lastTradeTime":1600459204365,"isUSMarketOpen":false}
 */
import Foundation

extension Quote: Identifiable {
    var id: UUID {
        return UUID()
    }
}

struct Quote: Codable {
    //let id = UUID()
    let symbol: String
    let companyName: String
    let primaryExchange: String
    let calculationPrice: String
    let welcomeOpen: Date?
    let openTime: Date?
    let openSource: String
    let close: Double?
    let closeTime: Date?
    let closeSource: String
    let high: Double?
    let highTime: Int
    let highSource: String
    let low: Double?
    let lowTime: Int
    let lowSource: String
    let latestPrice: Double
    let latestSource: String
    let latestTime: String
    let latestUpdate: Int
    let latestVolume: Int?
    let iexRealtimePrice: Double?
    let iexRealtimeSize: Int?
    let iexLastUpdated: Int?
    let delayedPrice: Double?
    let delayedPriceTime: Double?
    let oddLotDelayedPrice: Double?
    let oddLotDelayedPriceTime: Double?
    let extendedPrice: Double?
    let extendedChange: Double?
    let extendedChangePercent: Double?
    let extendedPriceTime: Date?
    let previousClose: Double
    let previousVolume: Int
    let change: Double
    let changePercent: Double
    let volume: Int?
    let iexMarketPercent: Double?
    let iexVolume: Int?
    let avgTotalVolume: Int
    let iexBidPrice: Double?
    let iexBidSize: Int?
    let iexAskPrice: Int?
    let iexAskSize: Int?
    let iexOpen: Double?
    let iexOpenTime: Date?
    let iexClose: Double?
    let iexCloseTime: Date?
    let marketCap: Int
    let peRatio: Double
    let week52High: Double
    let week52Low: Double
    let ytdChange: Double
    let lastTradeTime: Date?
    let isUSMarketOpen: Bool

    
   // var latestPrice:Double
    //var previousClose:Double
    
    #if DEBUG
    //static let example = StockResponse(id: UUID(), symbol: "aapl", companyName:"apple", primaryExchange:"",calculationPrice:"3",latestPrice:400,previousClose:390)
    //static let `default` = StockResponse(id: UUID(), symbol: "aapl", companyName:"apple", primaryExchange:"",calculationPrice:"3",latestPrice:400,previousClose:390)
    static let `default` = Quote(//id: UUID(),
                                symbol: "error",
                                companyName: "error",
                                primaryExchange: "",
                                calculationPrice: "",
                                welcomeOpen: nil,
                                openTime: nil,
                                openSource: "",
                                close: nil,
                                closeTime: nil,
                                closeSource: "",
                                high: 0.0,
                                highTime: 0,
                                highSource: "",
                                low: 0.0,
                                lowTime: 0,
                                lowSource: "",
                                latestPrice: 0.0,
                                latestSource: "",
                                latestTime: "",
                                latestUpdate: 0,
                                latestVolume: nil,
                                iexRealtimePrice: 0.0,
                                iexRealtimeSize: 0,
                                iexLastUpdated: 0,
                                delayedPrice:  nil,
                                delayedPriceTime:  nil,
                                oddLotDelayedPrice:  nil,
                                oddLotDelayedPriceTime:  nil,
                                extendedPrice: nil,
                                extendedChange: nil,
                                extendedChangePercent: nil,
                                extendedPriceTime: nil,
                                previousClose: 0.0,
                                previousVolume: 0,
                                change: 0.0,
                                changePercent: 0.0,
                                volume: 0,
                                iexMarketPercent: 0.0,
                                iexVolume: 0,
                                avgTotalVolume: 0,
                                iexBidPrice: 0.0,
                                iexBidSize: 0,
                                iexAskPrice: 0,
                                iexAskSize: 0,
                                iexOpen: nil,
                                iexOpenTime: nil,
                                iexClose: nil,
                                iexCloseTime: nil,
                                marketCap: 0,
                                peRatio: 0.0,
                                week52High: 0.0,
                                week52Low: 0.0,
                                ytdChange: 0.0,
                                lastTradeTime: nil,
                                isUSMarketOpen: false
                                )
    #endif
}


/*
 {"symbol":"AAPL","companyName":"Apple, Inc.","primaryExchange":"QSAAND","calculationPrice":"tops","open":null,"openTime":null,"openSource":"icfoifla","close":null,"closeTime":null,"closeSource":"oafflici","high":null,"highTime":1609817951939,"highSource":"dmpe5 y1euicaeit lend r","low":null,"lowTime":1602767477025,"lowSource":"dceeriymted aue1p n 5il","latestPrice":132.54,"latestSource":"IEX real time price","latestTime":"10:11:28 AM","latestUpdate":1649992503117,"latestVolume":null,"iexRealtimePrice":131.51,"iexRealtimeSize":105,"iexLastUpdated":1662410599206,"delayedPrice":null,"delayedPriceTime":null,"oddLotDelayedPrice":null,"oddLotDelayedPriceTime":null,"extendedPrice":null,"extendedChange":null,"extendedChangePercent":null,"extendedPriceTime":null,"previousClose":135,"previousVolume":200670860,"change":-4.52,"changePercent":-0.0343,"volume":null,"iexMarketPercent":0.015528995571654904,"iexVolume":610080,"avgTotalVolume":196273033,"iexBidPrice":129.7,"iexBidSize":105,"iexAskPrice":133,"iexAskSize":101,"iexOpen":null,"iexOpenTime":null,"iexClose":127.67,"iexCloseTime":1620057026390,"marketCap":2237566735252,"peRatio":39.5,"week52High":142.82,"week52Low":51.52,"ytdChange":0.724483,"lastTradeTime":1605389815420,"isUSMarketOpen":true}
 
 
 {"symbol":"AMZN","companyName":"Amazon.com, Inc.","primaryExchange":"NASDAQ","calculationPrice":"close","open":3031.74,"openTime":1600435800425,"openSource":"official","close":2954.91,"closeTime":1600459201289,"closeSource":"official","high":3037.8,"highTime":1600465683361,"highSource":"15 minute delayed price","low":2905.54,"lowTime":1600450275612,"lowSource":"15 minute delayed price","latestPrice":2954.91,"latestSource":"Close","latestTime":"September 18, 2020","latestUpdate":1600459201289,"latestVolume":8882179,"iexRealtimePrice":2951.465,"iexRealtimeSize":97,"iexLastUpdated":1600459196440,"delayedPrice":2947.9,"delayedPriceTime":1600465626138,"oddLotDelayedPrice":2297.87,"oddLotDelayedPriceTime":1600461196909,"extendedPrice":2947.34,"extendedChange":-7.57,"extendedChangePercent":-0.00256,"extendedPriceTime":1600473598955,"previousClose":3008.73,"previousVolume":6449050,"change":-53.82,"changePercent":-0.01789,"volume":8882179,"iexMarketPercent":0.011800144986945208,"iexVolume":104811,"avgTotalVolume":4514199,"iexBidPrice":0,"iexBidSize":0,"iexAskPrice":0,"iexAskSize":0,"iexOpen":null,"iexOpenTime":null,"iexClose":2951.465,"iexCloseTime":1600459196440,"marketCap":1480084869900,"peRatio":111.61,"week52High":3552.25,"week52Low":1626.03,"ytdChange":0.567312,"lastTradeTime":1600459200842,"isUSMarketOpen":false}
 
 
 */
