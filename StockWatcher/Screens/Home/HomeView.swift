//
//  HomeView.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI


struct HomeView: View {
    let stockList = ["AAPL","MSFT","GOOGL","NFLX","AMZN"]
    
    let stockWatcherList = StockWatcherList()
    /*
    for item in stockList {
        self.addSymbol(stockSymbol:item)
    }
    */
    
    

    //@State private var results = StockResponse(symbol: "aapl", companyName:"apple", primaryExchange:"",calculationPrice:"3",latestPrice:400,previousClose:390)
    //let results = IEX_API_Manager.shared.getStock()
    
    let rest = RestManager()
    
    //I need a datastore of an array of Stocks
    //I need a funt to go get stock responses from stock list
    //I need a way to refresh teh datastore
    
    var body: some View {
        /*NavigationView {
            List {
                ForEach(self.stockList, id:\.self) {stockSymbol in
                    HomeViewRow(item:stockSymbol)

                } 
            }
            .navigationTitle("My Stocks")
            .listStyle((GroupedListStyle()))
        }*/
        Text("hello")
    }

}
     

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
