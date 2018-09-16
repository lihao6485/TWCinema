//
//  MainViewController.swift
//  TWCinema
//
//  Created by Li Hao Lai on 12/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController, ViewType {

    typealias ViewModel = MainViewModel

    var viewModel: MainViewModel!

    var disposeBag: DisposeBag!

    private var movieListArraySubject = BehaviorRelay<[MovieList]>(value: [])

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Color.homeCellBg
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)

        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()

    private lazy var footerView: UIView = {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100))
        let loadingIndicator = UIActivityIndicatorView()

        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.startAnimating()

        [loadingIndicator].forEach(footerView.addSubview)

        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            loadingIndicator.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 10),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 40),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 40)
            ])

        return footerView
    }()

    func layout() {
        navigationItem.title = "Main"

        tableView.refreshControl = refreshControl
        tableView.tableFooterView = footerView

        [tableView].forEach(view.addSubview)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }

    func bind() {
        let fetchNextPageObservable = tableView.rx
            .contentOffset
            .asObservable()
            .filter { $0.y + self.tableView.frame.height + 20 > self.tableView.contentSize.height }
            .withLatestFrom(movieListArraySubject.asObservable())
            .map { $0.last?.page ?? 0 + 1 }

        let refreshControlObservable = refreshControl.rx.controlEvent(.valueChanged).asObservable()

        let output = viewModel.transform(input: .init(fetchNextPageObservable: fetchNextPageObservable,
                                                      refreshControlObservable: refreshControlObservable))

        output.nextMovieListDriver
            .filter { !$0.results.isEmpty }
            .drive(onNext: { [weak self] list in
                guard let `self` = self else { return }
                self.movieListArraySubject.accept(self.movieListArraySubject.value + [list])
            })
            .disposed(by: disposeBag)

        output.refreshControlDriver
            .drive(onNext: { [weak self] list in
                guard let `self` = self else { return }
                self.movieListArraySubject.accept([list])
                self.refreshControl.endRefreshing()
            })
            .disposed(by: disposeBag)

        movieListArraySubject.asDriver()
            .map { movieListArray -> [Movie] in
                return movieListArray.flatMap { $0.results }
            }
            .drive(tableView.rx.items(cellIdentifier: MainTableViewCell.identifier)) { _, model, cell in
                guard let mainCell = cell as? MainTableViewCell else {
                    return
                }

                mainCell.viewModel = MainTableViewCellViewModel()
                mainCell.layout()
                mainCell.bind(movie: model)
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(Movie.self).asObservable()
            .subscribe(onNext: { [weak self] movie in
                let movieViewModel = MovieViewModel(movie: movie)
                let movieViewController = MovieViewController(viewModel: movieViewModel)

                self?.navigationController?.pushViewController(movieViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }

}
