//
//  LogInDataSource.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/27.
//

import Foundation
import RxSwift

public protocol LogInDataSource {
    func requestLogIn(id: String, password: String) -> Observable<Bool>
    func requestSignIn(id: String, password: String) -> Observable<Bool>
    func searchPassword(id: String) -> Observable<Bool>
}
