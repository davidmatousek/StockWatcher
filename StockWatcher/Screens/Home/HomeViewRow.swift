//
//  HomeViewRow.swift
//  StockWatcher
//
//  Created by Matousek, David on 8/3/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI

struct HomeViewRow: View {
    var item: Stock
    @State private var isRed: Bool = false
    @State private var isGreen: Bool = false
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.symbol)
            Spacer()
            Text(item.companyName)
                .font(.caption)
        }
        
        Spacer()
        VStack(alignment: .trailing){
            //Text(String(item.latestPrice))
           Text("$\(item.latestPrice, specifier: "%.2f")")
           Text("$\(item.change, specifier: "%.2f") (\(item.changePercent*100, specifier: "%.2f")%)")
            .foregroundColor(self.isRed ? .red : self.isGreen ? .green : .black)
        }.onAppear (
            perform: {
                if item.change > 0.0 {
                    self.isGreen = true
                }
                if item.change < 0.0  {
                    self.isRed = true
                }
            }
        )

    }
    
/*
    let rest = RestManager()
    
    @State private var results : StockResponse = StockResponse.example
    
    func loadData() {
     /*
            //https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=
            //https://cloud.iexapis.com/stable/stock/AAPL/quote?token=
        
         */
            let delegate = UIApplication.shared.delegate as! AppDelegate

            let token = delegate.IEXSandboxToken
            let host = "https://sandbox.iexapis.com"
            let basePath = "/stable/stock/" + item + "/quote"
            
                    //let Url = String(format: "https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=")
            let Url = host + basePath + "?token=" + token
            
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
        }*/
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        //HomeViewRow(item:StockResponse.example)
        HomeViewRow(item:Stock.default)
    }
}


