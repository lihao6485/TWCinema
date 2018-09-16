//
//  MovieViewModel.swift
//  TWCinema
//
//  Created by Li Hao Lai on 16/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

class MovieViewModel: ViewModelType {

    typealias Input = Void

    struct Output {
        let movieTitle: String
        let posterImageURL: Driver<URL>
        let overview: String
        let popularity: Double
        let voteCount: Int
        let voteAverage: Double
        let releaseDate: Date
    }

    private var movie: Movie

    init(movie: Movie) {
        self.movie = movie
    }

    func transform(input: Input) -> Output {
        debugPrint(movie)
        let posterURL = getPosterHost().map { [weak self] host -> URL? in
            guard let posterPath = self?.movie.posterPath else {
                return URL(string: "")
            }
            return URL(string: host + posterPath)
            }.asDriver(onErrorJustReturn: nil)
            .filterNil()

        return .init(movieTitle: movie.title, posterImageURL: posterURL, overview: movie.overview,
                     popularity: movie.popularity, voteCount: movie.voteCount, voteAverage: movie.voteAverage,
                     releaseDate: movie.releaseDate)
    }

    private func getPosterHost() -> Single<String> {
        return AppServiceProvider.shared.configurationService.configurations()
            .map { $0.imageHost }
    }
}
