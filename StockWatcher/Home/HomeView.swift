//
//  HomeView.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State private var results = StockResponse(symbol: "", companyName:"", primaryExchange:"",calculationPrice:"",latestPrice:0,previousClose:0)

    let rest = RestManager()
    
    var body: some View {
            VStack(alignment: .leading) {
                Text(results.symbol)
                    .font(.headline)
                Text(results.companyName)
        }.onAppear(perform: loadData)
    }
    
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
                  guard let userData = try? decoder.decode(StockResponse.self, from: data) else { return }
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
