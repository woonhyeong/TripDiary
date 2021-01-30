//
//  apiService.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/26.
//

import Foundation
import RxSwift

public protocol APIService {
    func request()
}

public protocol APIRequestable {
    var path: String { get }
    var method: HTTPMethod { get }
    var contentType: HTTPContentType { get }
    var queryParameters: [String: Any] { get }
    var headerParamaters: [String: String] { get }
    var bodyParamaters: [String: Any] { get }
}
