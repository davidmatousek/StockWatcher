//
//  Response.swift
//  StockWatcher
//
//  Created by Matousek, David on 9/19/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation

struct Response: Codable {
    //var symbol: String

    var stock: [Stock]

    init (stock: [Stock]) {
        self.stock = stock
    }
    // Define DynamicCodingKeys type needed for creating
        // decoding container from JSONDecoder
        private struct DynamicCodingKeys: CodingKey {

            // Use for string-keyed dictionary
            var stringValue: String
            init?(stringValue: String) {
                self.stringValue = stringValue
            }

            // Use for integer-keyed dictionary
            var intValue: Int?
            init?(intValue: Int) {
                // We are not using this, thus just return nil
                return nil
            }
        }

        init(from decoder: Decoder) throws {

            // 1
            // Create a decoding container using DynamicCodingKeys
            // The container will contain all the JSON first level key
            let container = try decoder.container(keyedBy: DynamicCodingKeys.self)

            var tempArray = [Stock]()

            // 2
            // Loop through each key (student ID) in container
            for key in container.allKeys {

                // Decode Student using key & keep decoded Student object in tempArray
                var decodedObject = try container.decode(Stock.self, forKey: DynamicCodingKeys(stringValue: key.stringValue)!)
                decodedObject.symbol = key.stringValue
                tempArray.append(decodedObject)
            }

            // 3
            // Finish decoding all Student objects. Thus assign tempArray to array.
            stock = tempArray
            //print(stock)
        }

    
    #if DEBUG

    static let `default` = Response (
                               
        stock: []

                                )
    #endif
}
