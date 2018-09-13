//
//  ConfigurationRepository.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import RxSwift

struct ConfigurationsRepository {

    private let storage: ConfigurationStorage

    init(storage: ConfigurationStorage) {
        self.storage = storage
    }

    func configuration() -> Single<Configuration> {
        return storage.configuration()
    }
}
