//
//  StockList.swift
//  StockWatcher
//
//  Created by Matousek, David on 9/17/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class StockList: ObservableObject {
    @Published var stockList = Response(stock: [])
    @Published var isLoadingStocks = false
    @ObservedObject var watchList = WatchList()
    @ObservedObject var rest = RESTManager()
    
    init() {
        
    }
    
    func add(stock:Quote) {
        
    }
    func remove(stock:Quote) {
//        if let index = self.stockList.firstIndex(where: { $0.symbol == stock.symbol }) {
//            self.stockList.remove(at: index)
//        }
    }
    func removeAll() {
        //self.stockList.removeAll()
    }
    
  
    
    func refreshStockList(prod environment:Bool) {
        isLoadingStocks.toggle()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let token = delegate.IEXSandboxToken
        let tokenProd = delegate.IEXProductionToken

       // self.stockList = [Stock]()
        
        //removeAll()
        //stable/stock/market/batch?symbols=aapl,fb&types=quote,news,chart&range=1m&last=5&token=Tsk_8d37353c75bd4380939cbeab573a727b
        
        //for item in watchList.watchList {
            let host = "https://sandbox.iexapis.com"
            let hostProd = "https://cloud.iexapis.com"
            let basePath =  "/stable/stock/market/batch?"
            //let symbolPath = "symbols=" + item
            let symbolPath = "symbols=aapl,msft,nflx,googl,amzn"
            //let symbolPath = "symbols=aapl"
            let typesPath = "&types=quote,news,chart"
            let rangePath = "&range=1m&last=5"
            
            let urlString = host + basePath + symbolPath + typesPath + rangePath + "&token=" + token
            let urlProdString = hostProd + basePath + symbolPath + typesPath + rangePath + "&token=" + tokenProd
            
            //let urlString : String = "https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=" + token
            
            var url:URL
            print("url:\(urlProdString)")
            //ERROR HERE IF YOU DON'T REPLQCE YOUR TOKIN's
            if environment {
                url = URL(string: urlProdString)!
            } else {
                url = URL(string: urlString)!
            }
            rest.fetch(url, defaultValue: Response.default){
                print($0)
                //print($0.latestPrice)
//                self.remove(stock:$0)
                self.stockList = $0
                //self.stockList.append($0)
                self.stockList.stock.sort { $0.symbol! < $1.symbol! }
            }
            //print(rest.$requests)
        //}

    }
    
}
