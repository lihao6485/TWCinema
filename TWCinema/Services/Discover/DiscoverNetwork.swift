//
//  DiscoverNetwork.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public enum DiscoverNetworkError: Error {
    case decoding
}

struct DiscoverNetwork {
    enum Path: String {
        case discover = "/3/discover/movie"
    }

    private let sessionManager: Alamofire.SessionManager
    private let configurationStorage: ConfigurationStorage

    init(sessionManager: Alamofire.SessionManager, configurationStorage: ConfigurationStorage) {
        self.sessionManager = sessionManager
        self.configurationStorage = configurationStorage
    }

    private func buildDiscoverURLRequest(with page: Int) -> Single<URLRequest> {
        return configurationStorage.configuration()
            .flatMap { configuration -> Single<URLRequest> in
                return UrlRequestBuilder(httpMethod: .get, scheme: .https, host: configuration.apiHost,
                                         path: Path.discover.rawValue,
                                         query: [URLQueryItem(name: "api_key", value: configuration.apiKey),
                                                 URLQueryItem(name: "page", value: "\(page)")])
                    .buildUrlRequest()
            }
    }

    func makeDiscoverRequest(with page: Int) -> Single<MovieList> {
        return buildDiscoverURLRequest(with: page)
            .flatMap { urlRequest -> Single<MovieList> in
                return RequestBuilder(sessionManager: self.sessionManager, urlRequest: urlRequest)
                    .request()
                    .map { data -> MovieList in
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                        do {
                            let movieList = try decoder.decode(MovieList.self, from: data)
                            return movieList
                        } catch {
                            throw DiscoverNetworkError.decoding
                        }
                    }.asSingle()
            }
    }
}
