//
//  HomeView.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI
/*
struct HomeView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)onAppear(perform: loadData)
        }
    }
}*/
struct HomeView: View {
    @State private var results = Response(symbol: "", companyName:"", primaryExchange:"",calculationPrice:"",latestPrice:0,previousClose:0)


    let rest = RestManager()
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(results.symbol)
                    .font(.headline)
                Text(results.companyName)
        }.onAppear(perform: loadData)
    }
    /*
     List(results, id: \.trackId) { item in
         VStack(alignment: .leading) {
             Text(item.trackName)
                 .font(.headline)
             Text(item.collectionName)
         }
     }
     */
    
    func loadData() {
 /*
        //https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=Tsk_8d37353c75bd4380939cbeab573a727b
        //https://cloud.iexapis.com/stable/stock/AAPL/quote?token=pk_7c11cd5930244a8984ec15ba59528b02
    
     */
        
                let Url = String(format: "https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=Tsk_8d37353c75bd4380939cbeab573a727b")
                guard let serviceUrl = URL(string: Url) else { return }
        rest.makeRequest(toURL: serviceUrl, withHttpMethod: .get) { (results) in
              if let data = results.data {
                  let decoder = JSONDecoder()
                  decoder.keyDecodingStrategy = .convertFromSnakeCase
                  guard let userData = try? decoder.decode(Response.self, from: data) else { return }
                self.results = userData
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




struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

/*(IEX_API_Manager().fetchStock { [weak self] (films) in
  self?.films = films
  DispatchQueue.main.async {
   // self?.tableView.reloadData()
    self.body.Text("")
      }
}*/
struct Response: Codable {
    //var results: [Result]
    var symbol: String
    var companyName:String
    var primaryExchange:String
    var calculationPrice:String

    var latestPrice:Double
    var previousClose:Double
}

struct Result: Codable {
    var symbol: String
    var companyName:String
    var latestPrice:Double
}

/*
 struct Response: Codable {
     var results: [Result]
 }

 struct Result: Codable {
     var trackId: Int
     var trackName: String
     var collectionName: String
 }
 */
func exampleFunction(){
}
/*
 {"symbol":"AAPL","companyName":"Apple, Inc.","primaryExchange":"NASDAQ","calculationPrice":"iexlasttrade","open":null,"openTime":null,"openSource":"official","close":null,"closeTime":null,"closeSource":"official","high":null,"highTime":1596053700559,"highSource":"15 minute delayed price","low":null,"lowTime":1596029403374,"lowSource":"15 minute delayed price","latestPrice":380.24,"latestSource":"IEX Last Trade","latestTime":"July 29, 2020","latestUpdate":1596052796903,"latestVolume":null,"iexRealtimePrice":380.24,"iexRealtimeSize":7,"iexLastUpdated":1596052796903,"delayedPrice":null,"delayedPriceTime":null,"oddLotDelayedPrice":null,"oddLotDelayedPriceTime":null,"extendedPrice":null,"extendedChange":null,"extendedChangePercent":null,"extendedPriceTime":null,"previousClose":373.01,"previousVolume":25906375,"change":7.23,"changePercent":0.01938,"volume":null,"iexMarketPercent":0.006126978535971929,"iexVolume":137522,"avgTotalVolume":34939202,"iexBidPrice":0,"iexBidSize":0,"iexAskPrice":0,"iexAskSize":0,"iexOpen":null,"iexOpenTime":null,"iexClose":380.24,"iexCloseTime":1596052796903,"marketCap":1648089441600,"peRatio":29.56,"week52High":399.82,"week52Low":192.58,"ytdChange":0.261298,"lastTradeTime":1596052800722,"isUSMarketOpen":false}
 */
/*
 private var films: [Film]?
 
func exampleFunction(){
    IEX_API_Manager().fetchStock {(films) in
      //self?.films = films
      DispatchQueue.main.async {
       // self?.tableView.reloadData()
        //self.body.Text("")
          }
    }
}*/

