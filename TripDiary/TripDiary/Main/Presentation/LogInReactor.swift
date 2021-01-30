//
//  LogInReactor.swift
//  TripDiary
//
//  Created by 이운형 on 2021/01/17.
//

import Foundation
import RxSwift
import ReactorKit

public class LogInReactor: Reactor {
    public let initialState: State = State()
    
    // Todo: remove it.
    // and inject repository in AppDelegate.
    private let repository = DefaultLogInRepository(remoteDataSource: RemoteLogInDataSource(), localDataSource: RemoteLogInDataSource())
    
    public enum Action {
        case signInUser(id: String, password: String)
    }
    
    public enum Mutation {
        case error
        case requestSignInUser
    }
    
    public enum Event {
        case nothing
        case loggedIn
        case apiError
    }
    
    public struct State {
        var event: Event = .nothing
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .signInUser:
            // Todo: Request API, store datasource
            return loginMutation()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .requestSignInUser:
            state.event = .loggedIn
        case .error:
            state.event = .apiError
        }
        
        return state
    }
}

extension LogInReactor {
    private func loginMutation() -> Observable<Mutation> {
        return repository.requestLogIn(id: "", password: "")
            .map {
                if $0 {
                    return Mutation.requestSignInUser
                }
                return Mutation.error
            }.catchError(handleError)
    }
}

extension LogInReactor {
    private func handleError(error: Error) -> Observable<Mutation> {
        return Mutation.error.just
    }
}

extension LogInReactor.Mutation {
    var just: Observable<LogInReactor.Mutation> {
        return Observable.just(self)
    }
}
