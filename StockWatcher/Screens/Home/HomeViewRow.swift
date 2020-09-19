//
//  HomeViewRow.swift
//  StockWatcher
//
//  Created by Matousek, David on 8/3/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI

struct HomeViewRow: View {
    var item: Quote
    //var item: Stock

    @ObservedObject var stockList = StockList()
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
            .layoutPriority(100)
           Text("$\(item.change, specifier: "%.2f") (\(item.changePercent*100, specifier: "%.2f")%)")
            .layoutPriority(100)
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
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        //HomeViewRow(item:StockResponse.example)
        HomeViewRow(item:Quote.default)
    }
}


