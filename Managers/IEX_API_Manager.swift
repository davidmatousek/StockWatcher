//
//  IEX_API_Manager.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation

final class IEX_API_Manager {
/*
    var films: [Film] = []
    private let domainUrlString = "https://cloud.iexapis.com/stable/stock/AAPL/quote?token=pk_7c11cd5930244a8984ec15ba59528b02"
    
func fetchStock(completionHandler: @escaping ([Film]) -> Void) {
    let url = URL(string: domainUrlString )!
    
    print("Error with the response, unexpected status code: \(url)")
    
    let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
      if let error = error {
        print("Error with fetching films: \(error)")
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse,
            (200...299).contains(httpResponse.statusCode) else {
        print("Error with the response, unexpected status code: \(response)")
        return
      }

      if let data = data,
        let filmSummary = try? JSONDecoder().decode(FilmSummary.self, from: data) {
        completionHandler(filmSummary.results ?? [])
      }
    })
    task.resume()
  }*/
}
