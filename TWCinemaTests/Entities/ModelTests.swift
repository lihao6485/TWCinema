//
//  ModelTests.swift
//  TWCinemaTests
//
//  Created by Li Hao Lai on 18/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import XCTest
@testable import TWCinema

class ModelTests: XCTestCase {

    func testMovieListEqual() {
        let movie = Movie(title: "Source", posterPath: "/source.png", popularity: 100,
                          overview: "Nice Movie", voteCount: 55, voteAverage: 7.5, releaseDate: Date())
        let movieLista = MovieList(page: 1, results: [movie], totalResults: 100, totalPages: 2)
        let movieListb = MovieList(page: 1, results: [movie], totalResults: 100, totalPages: 2)

        XCTAssertEqual(movieLista, movieListb)
    }

}
