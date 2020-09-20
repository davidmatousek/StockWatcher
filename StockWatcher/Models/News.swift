//
//  News.swift
//  StockWatcher
//
//  Created by Matousek, David on 9/19/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation

enum Lang {
    case en
    case fr
    case ne
}

struct News: Codable {
    var datetime: Int?
    var headline: String?
    var source: String?
    var url: String?
    var summary: String?
    var related: String?
    var image: String?
    //var lang: Lang?
    var hasPaywall: Bool?
    #if DEBUG

    static let `default` = News(
        datetime: 0, headline: "", source: "", url: "", summary: "", related: "", image: "",
        //lang: Lang.en,
        hasPaywall: false
                                )
    #endif
    
}


