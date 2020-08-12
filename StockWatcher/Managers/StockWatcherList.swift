//
//  StockWatcherList.swift
//  StockWatcher
//
//  Created by Matousek, David on 8/6/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI

class StockWatcherList: ObservableObject  {
    @Published var items = [StockResponse]()



    func add(item: StockResponse) {
        items.append(item)
    }

    func remove(item: StockResponse) {
        if let index = items.firstIndex(of: item) {
            items.remove(at: index)
        }
    }
    func addSymbol(stockSymbol: String) {
        //need to call API and add Response to watchlist

    }
    
    let rest = RestManager()
    
    private func loadData(stockSymbol: String){
     /*
            //https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=
            //https://cloud.iexapis.com/stable/stock/AAPL/quote?token=
        
         */
            let delegate = UIApplication.shared.delegate as! AppDelegate

            let token = delegate.IEXSandboxToken
            let host = "https://sandbox.iexapis.com"
            let basePath = "/stable/stock/" + stockSymbol + "/quote"
            
                    //let Url = String(format: "https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=")
            let Url = host + basePath + "?token=" + token
            
        guard let serviceUrl = URL(string: Url) else { return }
            rest.makeRequest(toURL: serviceUrl, withHttpMethod: .get) { (results) in
                  if let data = results.data {
                      let decoder = JSONDecoder()
                      decoder.keyDecodingStrategy = .convertFromSnakeCase
                      guard let userData = try? decoder.decode(StockResponse.self, from: data) else { return }
                    self.items.append(userData)
                  }
                  
                /*
                  if let response = results.response {
                      for (key, value) in response.headers.allValues() {
                          print(key, value)
                      }
                  }
                 */
              }
        }
    
}
