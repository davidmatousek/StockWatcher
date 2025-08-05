//
//  Quote.swift
//  StockWatcher
//
//  Updated for Alpha Vantage API
//

import Foundation

extension Quote: Identifiable {
    var id: String {
        return symbol
    }
}

// Alpha Vantage Global Quote Response wrapper
struct AlphaVantageResponse: Codable {
    let globalQuote: Quote
    
    private enum CodingKeys: String, CodingKey {
        case globalQuote = "Global Quote"
    }
}

// Alpha Vantage Quote model matching their API response
struct Quote: Codable {
    let symbol: String
    let open: String
    let high: String
    let low: String
    let price: String
    let volume: String
    let latestTradingDay: String
    let previousClose: String
    let change: String
    let changePercent: String
    
    private enum CodingKeys: String, CodingKey {
        case symbol = "01. symbol"
        case open = "02. open"
        case high = "03. high"
        case low = "04. low"
        case price = "05. price"
        case volume = "06. volume"
        case latestTradingDay = "07. latest trading day"
        case previousClose = "08. previous close"
        case change = "09. change"
        case changePercent = "10. change percent"
    }
    
    // Convenience computed properties for backwards compatibility
    var latestPrice: Double? {
        return Double(price)
    }
    
    var companyName: String {
        return symbol // Alpha Vantage doesn't provide company name in quote
    }
    
    var changeValue: Double? {
        return Double(change)
    }
    
    var changePercentValue: Double? {
        let cleanPercent = changePercent.replacingOccurrences(of: "%", with: "")
        return Double(cleanPercent)
    }
    
    #if DEBUG
    static let `default` = Quote(
        symbol: "AAPL",
        open: "150.00",
        high: "155.00",
        low: "148.00",
        price: "152.50",
        volume: "1000000",
        latestTradingDay: "2025-01-01",
        previousClose: "151.00",
        change: "1.50",
        changePercent: "0.99%"
    )
    #endif
}


/*
 {"symbol":"AAPL","companyName":"Apple, Inc.","primaryExchange":"QSAAND","calculationPrice":"tops","open":null,"openTime":null,"openSource":"icfoifla","close":null,"closeTime":null,"closeSource":"oafflici","high":null,"highTime":1609817951939,"highSource":"dmpe5 y1euicaeit lend r","low":null,"lowTime":1602767477025,"lowSource":"dceeriymted aue1p n 5il","latestPrice":132.54,"latestSource":"IEX real time price","latestTime":"10:11:28 AM","latestUpdate":1649992503117,"latestVolume":null,"iexRealtimePrice":131.51,"iexRealtimeSize":105,"iexLastUpdated":1662410599206,"delayedPrice":null,"delayedPriceTime":null,"oddLotDelayedPrice":null,"oddLotDelayedPriceTime":null,"extendedPrice":null,"extendedChange":null,"extendedChangePercent":null,"extendedPriceTime":null,"previousClose":135,"previousVolume":200670860,"change":-4.52,"changePercent":-0.0343,"volume":null,"iexMarketPercent":0.015528995571654904,"iexVolume":610080,"avgTotalVolume":196273033,"iexBidPrice":129.7,"iexBidSize":105,"iexAskPrice":133,"iexAskSize":101,"iexOpen":null,"iexOpenTime":null,"iexClose":127.67,"iexCloseTime":1620057026390,"marketCap":2237566735252,"peRatio":39.5,"week52High":142.82,"week52Low":51.52,"ytdChange":0.724483,"lastTradeTime":1605389815420,"isUSMarketOpen":true}
 
 
 {"symbol":"AMZN","companyName":"Amazon.com, Inc.","primaryExchange":"NASDAQ","calculationPrice":"close","open":3031.74,"openTime":1600435800425,"openSource":"official","close":2954.91,"closeTime":1600459201289,"closeSource":"official","high":3037.8,"highTime":1600465683361,"highSource":"15 minute delayed price","low":2905.54,"lowTime":1600450275612,"lowSource":"15 minute delayed price","latestPrice":2954.91,"latestSource":"Close","latestTime":"September 18, 2020","latestUpdate":1600459201289,"latestVolume":8882179,"iexRealtimePrice":2951.465,"iexRealtimeSize":97,"iexLastUpdated":1600459196440,"delayedPrice":2947.9,"delayedPriceTime":1600465626138,"oddLotDelayedPrice":2297.87,"oddLotDelayedPriceTime":1600461196909,"extendedPrice":2947.34,"extendedChange":-7.57,"extendedChangePercent":-0.00256,"extendedPriceTime":1600473598955,"previousClose":3008.73,"previousVolume":6449050,"change":-53.82,"changePercent":-0.01789,"volume":8882179,"iexMarketPercent":0.011800144986945208,"iexVolume":104811,"avgTotalVolume":4514199,"iexBidPrice":0,"iexBidSize":0,"iexAskPrice":0,"iexAskSize":0,"iexOpen":null,"iexOpenTime":null,"iexClose":2951.465,"iexCloseTime":1600459196440,"marketCap":1480084869900,"peRatio":111.61,"week52High":3552.25,"week52Low":1626.03,"ytdChange":0.567312,"lastTradeTime":1600459200842,"isUSMarketOpen":false}
 
 
 */
