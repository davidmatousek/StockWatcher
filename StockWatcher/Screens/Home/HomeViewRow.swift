//
//  HomeViewRow.swift
//  StockWatcher
//
//  Created by Matousek, David on 8/3/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI

struct HomeViewRow: View {
    var item: String
    
    var body: some View {
        Text(item)
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        //HomeViewRow(item:StockResponse.example)
        HomeViewRow(item:"AAPL")
    }
}
