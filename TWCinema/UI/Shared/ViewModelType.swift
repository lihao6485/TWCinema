//
//  ViewModelType.swift
//  TWCinema
//
//  Created by Li Hao Lai on 15/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import Foundation

protocol ViewModelType {

    associatedtype Input

    associatedtype Output

    func transform(input: Input) -> Output
}
