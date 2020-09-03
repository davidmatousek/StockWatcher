//
//  HomeView.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Combine
import SwiftUI


struct Message: Decodable, Identifiable {
    let id: Int
    let from: String
    let message: String
}

struct HomeView: View {
    @State private var requests = Set<AnyCancellable>()
    @State private var messages = [Message]()
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
        /*
        //Commented out because NavigationView Not supported in version
        NavigationView {
            List {
                ForEach(self.stockList, id:\.self) {stockSymbol in
                    HomeViewRow(item:stockSymbol)

                }
            }
            .navigationTitle("My Stocks")
            .listStyle((GroupedListStyle()))
        }
//        NavigationView {
//            List(messages) { message in
//                HStack {
//                    VStack(alignment: .leading) {
//                        Text(message.from)
//                            .font(.headline)
//
//                        Text(message.message)
//                            .foregroundColor(.secondary)
//                    }
//
//                    if favorites.contains(message.id) {
//                        Spacer()
//
//                        Image(systemName: "heart.fill")
//                            .foregroundColor(.red)
//                    }
//                }
//            }
//            .navigationTitle("Messages")
//        }
        .onAppear {/*
            let messagesURL = URL(string: "http://www.hackingwithswift.com/samples/user-messages.json")!
            let messagesTask = fetch(messagesURL, defaultValue: [Message]())

            let favoritesURL = URL(string: "http://www.hackingwithswift.com/samples/user-favorites.json")!
            let favoritesTask = fetch(favoritesURL, defaultValue: Set<Int>())

            let combined = Publishers.Zip(messagesTask, favoritesTask)

            combined.sink { loadedMessages, loadedFavorites in
                messages = loadedMessages
                favorites = loadedFavorites
             }
             .store(in: &requests)
             */
            let delegate = UIApplication.shared.delegate as! AppDelegate
            let token = delegate.IEXSandboxToken
            /*
            let host = "https://sandbox.iexapis.com"
            let basePath = "/stable/stock/" + stockSymbol + "/quote"
            let Url = host + basePath + "?token=" + token
            */
            let urlString : String = "https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=" + token
            let url = URL(string: urlString)!
            self.fetch(url, defaultValue: StockResponse.default) {
                print($0.companyName)
            }
        }
}

    
    func fetch<T: Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void) {
        let decoder = JSONDecoder()

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
