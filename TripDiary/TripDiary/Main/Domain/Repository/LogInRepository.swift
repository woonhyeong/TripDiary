//
//  LogInRepository.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/26.
//

import Foundation
import RxSwift

public protocol LogInRepository {
    func requestLogIn(id: String, password: String) -> Observable<Bool>
    func reqeustSignIn(id: String, password: String) -> Observable<Bool>
    func searchPassword(id: String) -> Observable<Bool>
}
