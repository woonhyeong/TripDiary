//
//  User.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/17.
//

import Foundation

public struct UserResponse: Codable {
    public var id: String?
    public var password: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case password
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
        password = try container.decodeIfPresent(String.self, forKey: .password)
    }
}
