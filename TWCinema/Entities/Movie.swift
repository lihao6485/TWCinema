//
//  Movie.swift
//  TWCinema
//
//  Created by Li Hao Lai on 13/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation

public struct Movie: Codable {
    let title: String
    let posterPath: String?
    let popularity: Double
    let overview: String
    let voteCount: Int
    let voteAverage: Double
    let releaseDate: Date

    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case popularity
        case overview
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}
