//
//  MovieViewController.swift
//  TWCinema
//
//  Created by Li Hao Lai on 16/9/18.
//  Copyright © 2018 Li Hao Lai. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieViewController: UIViewController, ViewType {

    typealias ViewModel = MovieViewModel

    var viewModel: MovieViewModel!

    var disposeBag: DisposeBag!

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = Color.homeCellBg

        return contentView
    }()

    private lazy var posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFit
        posterImageView.layer.cornerRadius = 6
        posterImageView.layer.masksToBounds = true

        return posterImageView
    }()

    private lazy var movieTitleLabel: UILabel = {
        let movieTitleLabel = UILabel()
        movieTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        movieTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        movieTitleLabel.textColor = UIColor.white
        movieTitleLabel.numberOfLines = 0

        return movieTitleLabel
    }()

    private lazy var overviewLabel: UILabel = {
        let overviewLabel = UILabel()
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        overviewLabel.textColor = UIColor.white
        overviewLabel.numberOfLines = 0

        return overviewLabel
    }()

    private lazy var informationLabel: UILabel = {
        let informationLabel = UILabel()
        informationLabel.translatesAutoresizingMaskIntoConstraints = false
        informationLabel.font = UIFont.boldSystemFont(ofSize: 16)
        informationLabel.textColor = UIColor.white
        informationLabel.text = "Information"

        return informationLabel
    }()

    private lazy var voteCountTitleLabel: UILabel = {
        let voteCountTitleLabel = UILabel()
        voteCountTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        voteCountTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        voteCountTitleLabel.textColor = UIColor.white
        voteCountTitleLabel.text = "Vote Count"

        return voteCountTitleLabel
    }()

    private lazy var voteCountLabel: UILabel = {
        let voteCountLabel = UILabel()
        voteCountLabel.translatesAutoresizingMaskIntoConstraints = false
        voteCountLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        voteCountLabel.textColor = UIColor.white
        voteCountLabel.numberOfLines = 0

        return voteCountLabel
    }()

    private lazy var avgReviewTitleLabel: UILabel = {
        let avgReviewTitleLabel = UILabel()
        avgReviewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        avgReviewTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        avgReviewTitleLabel.textColor = UIColor.white
        avgReviewTitleLabel.text = "Avg. Review"

        return avgReviewTitleLabel
    }()

    private lazy var avgReviewLabel: UILabel = {
        let avgReviewLabel = UILabel()
        avgReviewLabel.translatesAutoresizingMaskIntoConstraints = false
        avgReviewLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        avgReviewLabel.textColor = UIColor.white
        avgReviewLabel.numberOfLines = 0

        return avgReviewLabel
    }()

    private lazy var releaseDateTitleLabel: UILabel = {
        let releaseDateTitleLabel = UILabel()
        releaseDateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateTitleLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        releaseDateTitleLabel.textColor = UIColor.white
        releaseDateTitleLabel.text = "Release Date"

        return releaseDateTitleLabel
    }()

    private lazy var releaseDateLabel: UILabel = {
        let releaseDateLabel = UILabel()
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        releaseDateLabel.textColor = UIColor.white
        releaseDateLabel.numberOfLines = 0

        return releaseDateLabel
    }()

    private lazy var bookNowButton: UIButton = {
        let bookNowButton = UIButton()
        bookNowButton.translatesAutoresizingMaskIntoConstraints = false
        bookNowButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        bookNowButton.backgroundColor = UIColor.green
        bookNowButton.setTitle("Book Now!", for: .normal)
        bookNowButton.setTitleColor(UIColor.white, for: .normal)
        bookNowButton.layer.cornerRadius = 6.0
        bookNowButton.layer.masksToBounds = true

        return bookNowButton
    }()

    func layout() {
        navigationItem.title = "Movie"

        view.backgroundColor = Color.homeCellBg

        [scrollView].forEach(view.addSubview)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor)
            ])

        [contentView].forEach(scrollView.addSubview)

        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            ])

        [posterImageView, movieTitleLabel, overviewLabel, informationLabel, voteCountTitleLabel,
         voteCountLabel, avgReviewTitleLabel, avgReviewLabel, releaseDateTitleLabel, releaseDateLabel, bookNowButton]
            .forEach(contentView.addSubview)

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            posterImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22),
            posterImageView.heightAnchor.constraint(equalToConstant: 460),

            movieTitleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 40),
            movieTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            movieTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22),

            overviewLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: 20),
            overviewLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            overviewLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22),

            informationLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 16),
            informationLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            informationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22),

            voteCountTitleLabel.centerYAnchor.constraint(equalTo: voteCountLabel.centerYAnchor),
            voteCountTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            voteCountTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),

            voteCountLabel.topAnchor.constraint(equalTo: informationLabel.bottomAnchor, constant: 12),
            voteCountLabel.leftAnchor.constraint(equalTo: voteCountTitleLabel.rightAnchor, constant: 8),
            voteCountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22),

            avgReviewTitleLabel.centerYAnchor.constraint(equalTo: avgReviewLabel.centerYAnchor),
            avgReviewTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            avgReviewTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),

            avgReviewLabel.topAnchor.constraint(equalTo: voteCountLabel.bottomAnchor, constant: 12),
            avgReviewLabel.leftAnchor.constraint(equalTo: avgReviewTitleLabel.rightAnchor, constant: 8),
            avgReviewLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22),

            releaseDateTitleLabel.centerYAnchor.constraint(equalTo: releaseDateLabel.centerYAnchor),
            releaseDateTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            releaseDateTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),

            releaseDateLabel.topAnchor.constraint(equalTo: avgReviewLabel.bottomAnchor, constant: 12),
            releaseDateLabel.leftAnchor.constraint(equalTo: avgReviewTitleLabel.rightAnchor, constant: 8),
            releaseDateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22),

            bookNowButton.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 22),
            bookNowButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -22),
            bookNowButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 22),
            bookNowButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -22)
            ])
    }

    func bind() {
        let output = viewModel.transform(input: ())

        movieTitleLabel.text = output.movieTitle
        overviewLabel.text = output.overview
        voteCountLabel.text = "\(output.voteCount)"
        avgReviewLabel.text = String(format: "%.2f", output.voteAverage)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        releaseDateLabel.text = dateFormatter.string(from: output.releaseDate)

        output.posterImageURL
            .drive(onNext: { [weak self] url in
                self?.posterImageView.kf.setImage(with: url)
            })
            .disposed(by: disposeBag)

        bookNowButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let alert = UIAlertController(title: nil, message: "Coming soon!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }

}
