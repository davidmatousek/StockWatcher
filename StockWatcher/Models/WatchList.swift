//
//  StockList.swift
//  StockWatcher
//
//  Created by Matousek, David on 9/17/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation

class WatchList: ObservableObject {
    @Published var watchList = [String]()
    let defaults = UserDefaults.standard
    
    init() {
        self.watchList = defaults.object(forKey:"Watchlist") as? [String] ?? [String]()
        
        if self.watchList.count == 0 {
            self.watchList = ["AAPL","MSFT","GOOGL","NFLX","AMZN"]
            defaults.set(self.watchList, forKey: "Watchlist")
        }
    }
    
    func add(stock:String) {
        
    }
    func remove(stock:String) {
        
    }
    
    
}
