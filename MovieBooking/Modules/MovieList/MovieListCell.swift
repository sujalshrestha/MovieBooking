//
//  MovieListCell.swift
//  MovieBooking
//
//  Created by Sujal on 4/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListCell: UICollectionViewCell {
    
    static let cellId = "movieList"
    
    let posterImage = UIImageView(image: nil, contentMode: .scaleAspectFill, clipsToBounds: true)
    let title = UILabel(text: "", color: .white, font: Poppins.regular, size: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private func setupView() {
        addSubview(posterImage)
        posterImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 32, right: 0))
        
        addSubview(title)
        title.anchor(top: posterImage.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 4, left: 8, bottom: 4, right: 4))
    }
    
    func configureCell(with data: MovieListData?) {
        guard let data = data else { return }
        title.text = data.title ?? ""
        let imageUrl = URL(string: ApiConstants.imagePath + (data.poster_path ?? ""))
        posterImage.kf.setImage(with: imageUrl)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
