//
//  HomeView.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Combine
import SwiftUI

struct HomeView: View {
    @State private var requests = Set<AnyCancellable>()
    @State private var stocks = [Stock]()
    @State private var stockResult = Stock.default
    @State private var favorites = Set<Int>()
    let stockList = ["AAPL","MSFT","GOOGL","NFLX","AMZN"]
    
    //let stockWatcherList = StockWatcherList()
    
    let rest = RestManager()

    //I need a way to refresh teh datastore
    
    var body: some View {
        NavigationView {
            List(stocks, id: \.symbol) {stockSymbol in
                NavigationLink(destination: DetailView()) {
                    HomeViewRow(item:stockSymbol)
                }
            }
            .navigationTitle("My Stocks")
            .listStyle((GroupedListStyle()))
        }

            .onAppear {

                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let token = delegate.IEXSandboxToken
                let tokenProd = delegate.IEXProductionToken
   
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
                    self.fetch(url, defaultValue: Stock.default) {
                        print($0)
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
   
    ////Fetch the Old Way
//    func fetch(_ url: URL) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print(Stock.default.companyName)
//            } else if let data = data {
//                let decoder = JSONDecoder()
//
//                do {
//                    let stockInfo = try decoder.decode(Stock.self, from: data)
//                    stockResult = stockInfo
//                    print(stockInfo)
//                } catch {
//                    print(Stock.default.companyName)
//                }
//            }
//        }.resume()
//    }
    
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
