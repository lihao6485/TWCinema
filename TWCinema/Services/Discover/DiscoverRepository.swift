//
//  DiscoverRepository.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import RxSwift

final class DiscoverRepository {

    private let network: DiscoverNetwork

    init(network: DiscoverNetwork) {
        self.network = network
    }

    func discoverMovieList(with page: Int) -> Single<MovieList> {
        return network.makeDiscoverRequest(with: page)
    }
}
