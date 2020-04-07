//
//  MovieTimeCell.swift
//  MovieBooking
//
//  Created by Sujal on 4/5/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class MovieTimeCell: UICollectionViewCell {
    
    static let cellId = "movieTimeCell"
    
    let timing = UILabel(text: "", color: .white, font: Poppins.regular, size: 13, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupView()
    }
    
    private func setupCell() {
        backgroundColor = .black
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
    private func setupView() {
        addSubview(timing)
        timing.centerInSuperview()
    }
    
    func configureCell(with data: String) {
        timing.text = data
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
