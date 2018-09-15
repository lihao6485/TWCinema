//
//  RequestBuilder.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
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
        return sessionManager.rx.request(urlRequest: urlRequest)
            .flatMap {
                $0
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .rx
                .data()
            }
    }
}
