//
//  AppServiceProvider.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import Alamofire

struct AppServiceProvider {

    static let shared: AppServiceProvider = {
        return AppServiceProvider()
    }()

    let configurationService: ConfigurationsService
    let discoverService: DiscoverService

    init() {
        //swiftlint:disable force_try
        let configurationStorage = try! ConfigurationStorage()
        let configurationRepository = ConfigurationsRepository(storage: configurationStorage)
        configurationService = ConfigurationsService(repository: configurationRepository)

        let sessionManager = Alamofire.SessionManager()
        let discoverNetwork = DiscoverNetwork(sessionManager: sessionManager,
                                              configurationStorage: configurationStorage)
        let discoverRepository = DiscoverRepository(network: discoverNetwork)
        discoverService = DiscoverService(repository: discoverRepository)
    }
}
