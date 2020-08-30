//
//  HomeView.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI


struct HomeView: View {
    static let stockList = ["AAPL","MSFT","GOOGL","NFLX","AMZN"]
    
    //@State private var results = StockResponse(symbol: "aapl", companyName:"apple", primaryExchange:"",calculationPrice:"3",latestPrice:400,previousClose:390)
    //let results = IEX_API_Manager.shared.getStock()
    
    let rest = RestManager()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(HomeView.stockList, id:\.self) {stockSymbol in
                    HomeViewRow(item:stockSymbol)
                } 
            }.navigationTitle("Menu").listStyle((GroupedListStyle()))
        }
        //Text("hello")
    }

}
     

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
