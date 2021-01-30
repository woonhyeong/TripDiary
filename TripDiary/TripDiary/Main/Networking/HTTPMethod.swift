//
//  HTTPMethod.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/27.
//

import Foundation

public enum HTTPMethod: String {
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public enum HTTPContentType: String {
    case binary
    case json
    case form
}
