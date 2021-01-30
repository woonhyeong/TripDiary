//
//  User.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/26.
//

import Foundation

public struct User {
    public var id: String
    public var password: String
    
    public init(id: String, password: String) {
        self.id = id
        self.password = password
    }
}
