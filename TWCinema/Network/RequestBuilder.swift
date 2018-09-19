//
//  RequestBuilder.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public enum RequestBuilderError: Error {
    case missing
}

struct RequestBuilder {
    private let sessionManager: Alamofire.SessionManager
    private let urlRequest: URLRequest

    init(sessionManager: Alamofire.SessionManager, urlRequest: URLRequest) {
        self.sessionManager = sessionManager
        self.urlRequest = urlRequest
    }

    public func request() -> Observable<Data> {
        return Observable.deferred {
            return Observable.create { observer -> Disposable in
                let request = self.sessionManager.request(self.urlRequest)
                    .responseData(completionHandler: { response in
                        switch response.result {
                        case .success(let value):
                            observer.on(.next(value))
                            observer.on(.completed)
                        case .failure(let error):
                            observer.on(.error(error))
                        }
                    })

                return Disposables.create { request.cancel() }
            }
        }
    }
}
