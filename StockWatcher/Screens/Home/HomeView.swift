//
//  HomeView.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Combine
import SwiftUI

struct HomeView: View {
    @ObservedObject var watchList = WatchList()
    @ObservedObject var stockList = StockList()
private var prod = true

    //I need a way to refresh teh datastore
    
    var body: some View {
        NavigationView {
            //List(stockList.stockList, id: \.symbol) {stockSymbol in
            List {
  

                Section{
                    ForEach(stockList.stockList, id: \.symbol) {stock in
                        NavigationLink(destination: DetailView(item: stock)) {
                            HomeViewRow(item:stock)
                        }
                    }
                }
                Section {

                    Link("Data provided by IEX Cloud",
                          destination: URL(string: "https://iexcloud.io")!)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

            }
                .navigationBarItems(trailing:
                                        
                                Button(action: {stockList.refreshStockList(prod: prod)}) {
                                                    Image(systemName: "arrow.clockwise")
                                                        .imageScale(.large)
                                                        .foregroundColor(.gray)
                                                    }

                            )
                .id(UUID())
                .navigationTitle("My Stocks")
                .listStyle((InsetGroupedListStyle()))
            }
        .onAppear {
            stockList.refreshStockList(prod: prod)
        }
    }
  
   
}
     

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
