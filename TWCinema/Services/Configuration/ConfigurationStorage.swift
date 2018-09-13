//
//  ConfigurationStorage.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import RxSwift

public enum ConfigurationError: Error {
    case missing
    case decoding
}

struct ConfigurationStorage {
    private let configurationPath: URL
    private let bundle: Bundle

    public init(file: String = "Configuration", ofType type: String = "plist", inBundle bundle: Bundle = .main) throws {
        guard let configurationPath = bundle.path(forResource: file, ofType: type) else {
            throw ConfigurationError.missing
        }
        self.configurationPath = URL(fileURLWithPath: configurationPath)
        self.bundle = bundle
    }

    private func makeConfiguration() throws -> Configuration {
        guard let data = try? Data(contentsOf: configurationPath) else {
            throw ConfigurationError.missing
        }

        let decoder = PropertyListDecoder()
        guard let configuration = try? decoder.decode(Configuration.self, from: data) else {
            throw ConfigurationError.decoding
        }

        return configuration
    }

    func configuration() -> Single<Configuration> {
        do {
            return Observable.just(try makeConfiguration())
                .asSingle()
        } catch {
            return Observable.error(error)
                .asSingle()
        }
    }
}
