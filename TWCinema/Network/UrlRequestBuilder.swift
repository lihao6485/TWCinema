//
//  UrlBuilder.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import RxSwift

public enum UrlBuilderScheme: String {
    case http
    case https
}

public enum UrlRequestBuilderHTTPMethod: String {
    case get
    case post
    case put
    case delete
}

struct UrlRequestBuilder {
    let httpMethod: UrlRequestBuilderHTTPMethod
    let scheme: UrlBuilderScheme
    let host: String
    let path: String
    let query: [URLQueryItem]

    private func buildUrl() -> Single<URL> {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        components.path = path
        components.queryItems = query

        return Single.just(components.url!)
    }

    func buildUrlRequest() -> Single<URLRequest> {
        return buildUrl()
            .map { url -> URLRequest in
                var request = URLRequest(url: url)
                request.httpMethod = self.httpMethod.rawValue

                return request
            }
    }
}
