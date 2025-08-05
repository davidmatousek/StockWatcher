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
    
    var body: some View {
        NavigationView {
            List {
  

                Section{
                    ForEach(stockList.stockList.stock, id: \.symbol) {stock in
                        NavigationLink(destination: DetailView(item: stock)) {
                            HomeViewRow(item:stock.quote)
                        }
                    }
                }
                Section {
                    Link("Data provided by Alpha Vantage",
                          destination: URL(string: "https://www.alphavantage.co")!)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }

            }
                .alert(isPresented: $stockList.hasError) {
                    Alert(
                        title: Text("Error"),
                        message: Text(stockList.errorMessage ?? "An unknown error occurred"),
                        primaryButton: .default(Text("Retry")) {
                            stockList.refreshStockList(prod: prod)
                        },
                        secondaryButton: .cancel()
                    )
                }
                .navigationBarItems(trailing:
                                        
                                Button(action: {stockList.refreshStockList(prod: prod)}) {
                                                    Image(systemName: "arrow.clockwise")
                                                        .imageScale(.large)
                                                        .foregroundColor(.gray)
                                                    }

                            )
                // Removed .id(UUID()) to prevent unnecessary view recreation
                .navigationTitle("My Stocks")
                .listStyle(InsetGroupedListStyle())
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
