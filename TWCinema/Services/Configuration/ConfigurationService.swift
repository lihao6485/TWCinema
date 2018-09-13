//
//  ConfigurationService.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import RxSwift

struct ConfigurationsService {
    private let repository: ConfigurationsRepository

    init(repository: ConfigurationsRepository) {
        self.repository = repository
    }

    func configurations() -> Single<Configuration> {
        return repository.configuration()
    }
}
