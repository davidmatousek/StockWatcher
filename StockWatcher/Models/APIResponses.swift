//
//  APIResponses.swift
//  StockWatcher
//
//  Created by Matousek, David on 7/29/20.
//  Copyright © 2020 David Matousek. All rights reserved.
//

import Foundation

struct FilmSummary: Codable {
  let count: Int?
  let results: [Film]?
}

struct Film: Codable {
  let title: String
  let episodeId: Int
  
  enum CodingKeys: String, CodingKey {
    case title
    case episodeId = "episode_id"
  }
  
  init(title: String,
       episodeId: Int) {
    self.title = title
    self.episodeId = episodeId
  }
}
