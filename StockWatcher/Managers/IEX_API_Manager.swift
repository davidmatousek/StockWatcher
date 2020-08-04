//
//  IEX_API_Manager.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation
import SwiftUI

final class IEX_API_Manager {
    static let shared = IEX_API_Manager()
    let rest = RestManager()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //var results = StockResponse(symbol: "", companyName:"", primaryExchange:"",calculationPrice:"",latestPrice:0,previousClose:0)
    
    
    public func getStock() -> StockResponse{
        let results = getStock(symbol:"AAPL")
        return results
    }
    
    private func getStock(symbol: String) -> StockResponse {
        //https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=
        //https://cloud.iexapis.com/stable/stock/AAPL/quote?token=
        
        let results = StockResponse(symbol: "", companyName:"", primaryExchange:"",calculationPrice:"",latestPrice:0,previousClose:0)
        
        //let delegate = UIApplication.shared.delegate as! AppDelegate

        let token = appDelegate.IEXSandboxToken
        let host = "https://sandbox.iexapis.com"
        let basePath = "/stable/stock/AAPL/quote"
        
                //let Url = String(format: "https://sandbox.iexapis.com/stable/stock/AAPL/quote?token=")
        let Url = host + basePath + "?token=" + token
        
        guard let serviceUrl = URL(string: Url) else { return results}
        rest.makeRequest(toURL: serviceUrl, withHttpMethod: .get) { (results) in
              if let data = results.data {
                  let decoder = JSONDecoder()
                  decoder.keyDecodingStrategy = .convertFromSnakeCase
                  guard let userData = try? decoder.decode(StockResponse.self, from: data) else { return }
                 
                
                //if userData <> nil {return userData} else { return }
              }
            
            /*
              if let response = results.response {
                  for (key, value) in response.headers.allValues() {
                      print(key, value)
                  }
              }
             */
            
          }
        return results
    }

}
    

