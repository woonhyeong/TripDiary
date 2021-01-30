//
//  LogInAPIService.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/31.
//

import Foundation
import Alamofire
import RxSwift

public class LogInAPIService {
    public static let shared = LogInAPIService()
    
    private let baseURL: String = "https://swapi.dev/api/films"
    
    public func request() -> Observable<Bool> {
        let observable = Observable<Bool>.create { (observer) -> Disposable in
            let request = AF.request(self.baseURL).responseDecodable(of: Films.self) { (response) in
                if let error = response.error {
                    observer.onError(error)
                }
                
                if response.value != nil {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create(with: { request.cancel() })
        }
        
        return observable
    }
}
