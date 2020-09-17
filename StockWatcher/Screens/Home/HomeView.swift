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


    //I need a way to refresh teh datastore
    
    var body: some View {
        NavigationView {
            //List(stockList.stockList, id: \.symbol) {stockSymbol in
            List {
                GeometryReader { g -> Text in
                    let frame = g.frame (in:CoordinateSpace.global)
                    if frame.origin.y > 250 {
                        self.stockList.refreshStockList2()
                        return Text("Loading")
                    } else {
                        return Text("")
                    }
                }
                ForEach(stockList.stockList, id: \.symbol) {stock in
                    NavigationLink(destination: DetailView()) {
                        HomeViewRow(item:stock)
                    }
                }
            }
            .id(UUID())
            .navigationTitle("My Stocks")
            //.listStyle((GroupedListStyle()))
        }

            .onAppear {
                stockList.refreshStockList2()
            }
    }
    
   
}
     

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}



