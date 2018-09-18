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
        let fetchNextPageObservable: Driver<Int>
        let refreshControlObservable: Observable<Void>
    }

    struct Output {
        let nextMovieListDriver: Driver<MovieList>
        let refreshControlDriver: Driver<MovieList>
        let errorDriver: Driver<Error?>
    }

    private var errorSubject = BehaviorRelay<Error?>(value: nil)

    func transform(input: Input) -> Output {
        let nextMovieListDriver = input.fetchNextPageObservable
            .distinctUntilChanged()
            .flatMap { [weak self] page -> Driver<MovieList> in
                guard let `self` = self else {
                    return .just(MovieList(page: 0, results: [], totalResults: 0, totalPages: 0))
                }
                self.errorSubject.accept(nil)
                return self.fetchMovieList(page: page)
                    .asDriver(onErrorRecover: { [weak self] error -> Driver<MovieList> in
                        self?.errorSubject.accept(error)
                        return .just(MovieList(page: 0, results: [], totalResults: 0, totalPages: 0))
                    })
            }

        let refreshControlDriver = input.refreshControlObservable
            .flatMap { () -> Single<MovieList> in
                self.errorSubject.accept(nil)
                return self.fetchMovieList(page: 1)
            }
            .asDriver(onErrorRecover: { [weak self] error -> Driver<MovieList> in
                self?.errorSubject.accept(error)
                return .just(MovieList(page: 0, results: [], totalResults: 0, totalPages: 0))
            })

        return .init(nextMovieListDriver: nextMovieListDriver,
                     refreshControlDriver: refreshControlDriver,
                     errorDriver: errorSubject.asDriver(onErrorJustReturn: nil))
    }

    private func fetchMovieList(page: Int) -> Single<MovieList> {
        return AppServiceProvider.shared.discoverService.discoverMovieList(with: page)
    }
}
