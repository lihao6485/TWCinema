//
//  MainViewController.swift
//  TWCinema
//
//  Created by Li Hao Lai on 12/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import RxAlamofire

class MainViewController: UIViewController, ViewType {

    typealias ViewModel = MainViewModel

    var viewModel: MainViewModel!

    var disposeBag: DisposeBag!

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Color.homeCellBg
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension

        return tableView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()

    func layout() {
        navigationItem.title = "Main"

        tableView.refreshControl = refreshControl

        [tableView].forEach(view.addSubview)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])
    }

    func bind() {
    }

}
