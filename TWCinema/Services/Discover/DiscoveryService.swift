//
//  DiscoveryService.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import RxSwift

struct DiscoverService {
    private let repository: DiscoverRepository

    init(repository: DiscoverRepository) {
        self.repository = repository
    }

    func discoverMovieList(with page: Int) -> Single<MovieList> {
        return repository.discoverMovieList(with: page)
    }
}
