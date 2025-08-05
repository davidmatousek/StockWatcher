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
    
    // Computed property for change color
    private var changeColor: Color {
        guard let changeValue = item.changeValue else { return .primary }
        if changeValue > 0.0 {
            return .green
        } else if changeValue < 0.0 {
            return .red
        } else {
            return .primary
        }
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.symbol)
                Spacer()
                Text(item.companyName)
                    .font(.caption)
            }
            
            Spacer()
            VStack(alignment: .trailing){
                Text("$\(item.latestPrice ?? 0.0, specifier: "%.2f")")
                 .font(.caption)
                 .layoutPriority(100)
                Text("$\(item.changeValue ?? 0.0, specifier: "%.2f") (\(item.changePercentValue ?? 0.0, specifier: "%.2f")%)")
                 .font(.caption)
                 .layoutPriority(100)
                 .foregroundColor(changeColor)
            }
        }
    }
}

struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
        //HomeViewRow(item:StockResponse.example)
        HomeViewRow(item:Quote.default)
    }
}


