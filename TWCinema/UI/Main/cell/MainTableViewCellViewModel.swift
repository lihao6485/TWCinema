//
//  MainTableViewCellViewModel.swift
//  TWCinema
//
//  Created by Li Hao Lai on 15/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MainTableViewCellViewModel: ViewModelType {

    struct Input {
        let movie: Movie
    }

    struct Output {
        let posterURL: Driver<URL>
        let movieTitle: String
        let popularity: Double
    }

    func transform(input: Input) -> Output {
        let posterURL = getPosterHost().map { host -> URL? in
            guard let posterPath = input.movie.posterPath else {
                return URL(string: "")
            }
            return URL(string: host + posterPath)
        }.asDriver(onErrorJustReturn: nil)
        .filterNil()
        let movieTitle = input.movie.title
        let popularity = input.movie.popularity

        return .init(posterURL: posterURL, movieTitle: movieTitle, popularity: popularity)
    }

    private func getPosterHost() -> Single<String> {
        return AppServiceProvider.shared.configurationService.configurations()
            .map { $0.imageHost }
    }
}
