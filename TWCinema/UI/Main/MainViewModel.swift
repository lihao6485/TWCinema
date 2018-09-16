//
//  MainViewModel.swift
//  TWCinema
//
//  Created by Li Hao Lai on 15/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

class MainViewModel: ViewModelType {

    struct Input {
        let fetchNextPageObservable: Observable<Int>
        let refreshControlObservable: Observable<Void>
    }

    struct Output {
        let nextMovieListDriver: Driver<MovieList>
        let refreshControlDriver: Driver<MovieList>
    }

    func transform(input: Input) -> Output {
        let nextMovieListDriver = input.fetchNextPageObservable
            .distinctUntilChanged()
            .flatMap { page -> Single<MovieList> in
                return self.fetchMovieList(page: page)
            }
            .asDriver(onErrorJustReturn: MovieList(page: 0, results: [], totalResults: 0, totalPages: 0))

        let refreshControlDriver = input.refreshControlObservable
            .flatMap { () -> Single<MovieList> in
                return self.fetchMovieList(page: 1)
            }
            .asDriver(onErrorJustReturn: MovieList(page: 0, results: [], totalResults: 0, totalPages: 0))

        return .init(nextMovieListDriver: nextMovieListDriver, refreshControlDriver: refreshControlDriver)
    }

    private func fetchMovieList(page: Int) -> Single<MovieList> {
        return AppServiceProvider.shared.discoverService.discoverMovieList(with: page)
    }
}
