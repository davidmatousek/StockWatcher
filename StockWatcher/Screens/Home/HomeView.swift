//
//  HomeView.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Combine
import SwiftUI


struct stock: Codable  {
    let symbol: String
    let companyName: String
    let primaryExchange: String
    let calculationPrice: String
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
    let latestPrice: Double
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
    #if DEBUG
    static let `default` = stock(symbol: "error",
                                 companyName:"error",
                                 primaryExchange:"",
                                 calculationPrice:"",
                                 latestPrice:0
    )
    #endif
}


struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}

struct HomeView: View {
    @State private var requests = Set<AnyCancellable>()
    @State private var messages = [Message]()
    @State private var stocks = [stock]()
    @State private var stockResult = stock.default
    @State private var favorites = Set<Int>()
    let stockList = ["AAPL","MSFT","GOOGL","NFLX","AMZN"]
    
    let stockWatcherList = StockWatcherList()

    
    /*
    for item in stockList {
        self.addSymbol(stockSymbol:item)
    }
    */
    
    

    //@State private var results = StockResponse(symbol: "aapl", companyName:"apple", primaryExchange:"",calculationPrice:"3",latestPrice:400,previousClose:390)
    //let results = IEX_API_Manager.shared.getStock()
    
    let rest = RestManager()
    
    //I need a datastore of an array of Stocks
    //I need a funt to go get stock responses from stock list
    //I need a way to refresh teh datastore
    
    var body: some View {

        //Commented out because NavigationView Not supported in version
        NavigationView {
            List(stocks, id: \.symbol) {stockSymbol in
               HomeViewRow(item:stockSymbol)
               // Text(stockSymbol.companyName)
            }
            .navigationTitle("My Stocks")
            .listStyle((GroupedListStyle()))
//            VStack{
//                Text(self.stockResult.symbol)
//                Text(self.stockResult.companyName)
//                Text(self.stockResult.primaryExchange)
//                Text(self.stockResult.calculationPrice)
//
//            }
            
        }

            .onAppear {
                /*
                let host = "https://sandbox.iexapis.com"
                let basePath = "/stable/stock/" + stockSymbol + "/quote"
                let Url = host + basePath + "?token=" + token
                */
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let token = delegate.IEXSandboxToken
                let tokenProd = delegate.IEXProductionToken
                //let urlString : String = "https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=" + token
               /*
                guard let serviceUrl = URL(string: urlString) else { return }
                rest.makeRequest(toURL: serviceUrl, withHttpMethod: .get) { (results) in
                   if let data = results.data {
                       let decoder = JSONDecoder()
                       decoder.keyDecodingStrategy = .convertFromSnakeCase
                       guard let userData = try? decoder.decode(stock.self, from: data) else { return }
                    print(userData)
                    self.stocks.append(userData)
                   }
                }
                  */

                
//                self.fetch(url)
                let group = DispatchGroup()
                var urls = [URL]()
                let prod = true
                
                for item in stockList {
                    let host = "https://sandbox.iexapis.com"
                    let hostProd = "https://cloud.iexapis.com"
                    let basePath =  "/stable/stock/" + item + "/quote"
                    
    
                    let urlString = host + basePath + "?token=" + token
                    let urlProdString = hostProd + basePath + "?token=" + tokenProd
                    
                    //let urlString : String = "https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=" + token
                    
                    var url:URL
                    //ERROR HERE IF YOU DON'T REPLQCE YOUR TOKIN's
                    if prod {
                        url = URL(string: urlProdString)!
                    } else {
                        url = URL(string: urlString)!
                    }
                    urls.append(url)
                    //Dave-- Do this
                    //https://www.robertpieta.com/concurrent-api-calls-in-swift/
                }
                for url in urls {
                    group.enter()
                    self.fetch(url, defaultValue: stock.default) {
                        print($0.companyName)
                        //print($0.latestPrice)
                        stocks.append($0)
                        group.leave()
                    }
                }
                    
//                self.fetch(url, defaultValue: stock.default) {
//                    print($0.companyName)
//                    //print($0.latestPrice)
//                    stocks.append($0)
//                    stockResult = $0
//                }
            }
    }
    
    func fetch(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(stock.default.companyName)
            } else if let data = data {
                let decoder = JSONDecoder()

                do {
                    let stockInfo = try decoder.decode(stock.self, from: data)
                    stockResult = stockInfo
                    print(stockInfo.companyName)
                } catch {
                    print(stock.default.companyName)
                }
            }
        }.resume()
    }
    
    enum HTTPError: LocalizedError {
        case statusCode
    }
    
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        URLSession.shared.dataTaskPublisher(for: url)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .replaceError(with: defaultValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
    }

    func fetch<T: Decodable>(_ url: URL, defaultValue: T) -> AnyPublisher<T, Never> {
        let decoder = JSONDecoder()

        return URLSession.shared.dataTaskPublisher(for: url)
//            .delay(for: .seconds(Double.random(in: 1...5)), scheduler: RunLoop.main)
            .retry(1)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .replaceError(with: defaultValue)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
     

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
