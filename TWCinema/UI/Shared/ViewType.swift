//
//  ViewType.swift
//  TWCinema
//
//  Created by Li Hao Lai on 15/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewType: class {
    associatedtype ViewModel

    var viewModel: ViewModel! { get set }

    var disposeBag: DisposeBag! { get set }

    func layout()

    func bind()
}

extension ViewType where Self: UIViewController, Self.ViewModel: ViewModelType {

    init(viewModel: ViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.disposeBag = DisposeBag()
        self.viewModel = viewModel
        self.layout()
        self.bind()
    }
}

extension ViewType where Self: UITableViewCell {

    init(viewModel: ViewModel, style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.init(style: style, reuseIdentifier: reuseIdentifier)
        self.disposeBag = DisposeBag()
        self.viewModel = viewModel
        self.layout()
        self.bind()
    }
}
