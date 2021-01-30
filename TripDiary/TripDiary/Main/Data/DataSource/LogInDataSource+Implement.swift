//
//  LogInDataSource+Implement.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/31.
//

import Foundation
import RxSwift

public class RemoteLogInDataSource {
    
}

extension RemoteLogInDataSource: LogInDataSource {
    public func requestLogIn(id: String, password: String) -> Observable<Bool> {
        return LogInAPIService.shared.request()
    }
    
    public func requestSignIn(id: String, password: String) -> Observable<Bool> {
        return LogInAPIService.shared.request()
    }
    
    public func searchPassword(id: String) -> Observable<Bool> {
        return LogInAPIService.shared.request()
    }
}
