//
//  DetailView.swift
//  StockWatcher
//
//  Created by Matousek, David on 9/15/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    var item: Quote
    
    var body: some View {
        Form {
            Text(item.companyName)
            Text("Close:  \(item.close ?? 0)")
            Text(item.symbol)
            Text(item.companyName)
            Text(item.companyName)
            Text(item.companyName)
            
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(item: Quote.default)
    }
}
