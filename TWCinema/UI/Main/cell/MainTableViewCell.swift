//
//  MainTableViewCell.swift
//  TWCinema
//
//  Created by Li Hao Lai on 15/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class MainTableViewCell: UITableViewCell, ViewType {

    typealias ViewModel = MainTableViewCellViewModel

    var viewModel: MainTableViewCellViewModel!

    var disposeBag: DisposeBag!

    public static let identifier = String(describing: MainTableViewCell.self)

    private lazy var posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.layer.cornerRadius = 6
        posterImageView.layer.masksToBounds = true

        return posterImageView
    }()

    private lazy var movieTitle: UILabel = {
        let movieTitle = UILabel()
        movieTitle.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.textColor = UIColor.white
        movieTitle.font = UIFont.boldSystemFont(ofSize: 16)
        movieTitle.numberOfLines = 0

        return movieTitle
    }()

    private lazy var popularityLabel: UILabel = {
        let popularityLabel = UILabel()
        popularityLabel.translatesAutoresizingMaskIntoConstraints = false
        popularityLabel.textColor = UIColor.white
        popularityLabel.font = UIFont.boldSystemFont(ofSize: 12)
        popularityLabel.numberOfLines = 0
        popularityLabel.layer.cornerRadius = 6
        popularityLabel.layer.masksToBounds = true

        return popularityLabel
    }()

    func layout() {
        selectionStyle = .none
        contentView.backgroundColor = Color.homeCellBg

        [posterImageView, movieTitle, popularityLabel].forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            posterImageView.heightAnchor.constraint(equalToConstant: 130),
            posterImageView.widthAnchor.constraint(equalToConstant: 90),

            movieTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 26),
            movieTitle.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 16),
            movieTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),

            popularityLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10),
            popularityLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 16)
            ])
    }

    func bind() {

    }

    func bind(movie: Movie) {
        let output = viewModel.transform(input: .init(movie: movie))
        movieTitle.text = output.movieTitle
        popularityLabel.text = "Popularity: \(output.popularity)"

        output.posterURL
            .drive(onNext: { [weak self] url in
                guard let `self` = self else { return }
                self.posterImageView.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        disposeBag = DisposeBag()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
