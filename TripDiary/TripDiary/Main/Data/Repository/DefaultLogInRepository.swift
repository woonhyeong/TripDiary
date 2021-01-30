//
//  DefaultLogInRepository.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/26.
//

import Foundation
import RxSwift

public class DefaultLogInRepository {
    private let remoteDataSource: LogInDataSource
    private let localDataSource: LogInDataSource
    
    public init(remoteDataSource: LogInDataSource, localDataSource: LogInDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
}

extension DefaultLogInRepository: LogInRepository {
    public func requestLogIn(id: String, password: String) -> Observable<Bool> {
        return remoteDataSource.requestLogIn(id: id, password: password)
    }
    
    public func reqeustSignIn(id: String, password: String) -> Observable<Bool> {
        return remoteDataSource.requestSignIn(id: id, password: password)
    }
    
    public func searchPassword(id: String) -> Observable<Bool> {
        return remoteDataSource.searchPassword(id: id)
    }
}
