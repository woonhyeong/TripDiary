//
//  Flim+Response.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/31.
//

import Foundation

public struct Films: Decodable {
    public let count: Int
    public let all: [Film]
    
    private enum CodingKeys: String, CodingKey {
        case count
        case all = "results"
    }
}

public struct Film: Decodable {
    public let id: Int
    public let title: String
    public let openingCrawl: String
    public let director: String
    public let producer: String
    public let releaseDate: String
    public let starships: [String]
    
    private enum CodingKeys: String, CodingKey {
        case id = "episode_id"
        case title
        case openingCrawl = "opening_crawl"
        case director
        case producer
        case releaseDate = "release_date"
        case starships
    }
}
