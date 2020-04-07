//
//  ShowTimeView.swift
//  MovieBooking
//
//  Created by Sujal on 4/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ShowTimeView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    let bannerImage = UIImageView(image: nil, contentMode: .scaleAspectFill, clipsToBounds: true)
    let plot = UILabel(text: "", color: .white, font: Poppins.regular, size: 12, numberOfLines: 0)
    
    let movieTableView = UIView(color: .black)
    var movieTableHeight: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupScrollView()
        setupInfo()
        setupMovieTableView()
    }
    
    private func setupScrollView() {
        addSubview(scrollView)
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(contentView)
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupInfo() {
        bannerImage.constraintHeight(constant: 200)
        contentView.addSubview(bannerImage)
        bannerImage.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor)
        
        contentView.addSubview(plot)
        plot.anchor(top: bannerImage.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
    }
    
    private func setupMovieTableView() {
        contentView.addSubview(movieTableView)
        movieTableView.anchor(top: plot.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 16, left: 0, bottom: 30, right: 0))
        movieTableHeight = movieTableView.heightAnchor.constraint(equalToConstant: 200)
        movieTableHeight?.isActive = true
    }
    
    func configureView(with data: MovieListData) {
        plot.text = data.overview ?? ""
        let imageUrl = URL(string: ApiConstants.imagePath + (data.backdrop_path ?? ""))
        bannerImage.kf.setImage(with: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
