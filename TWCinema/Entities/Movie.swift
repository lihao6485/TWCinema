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

    enum CodingKeys: String, CodingKey {
        case title
        case posterPath = "poster_path"
        case popularity
    }
}
