//
//  BookingCell.swift
//  MovieBooking
//
//  Created by Sujal on 4/5/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class BookingCell: UICollectionViewCell {
    
    static let cellId = "bookingCell"
    
    let title = UILabel(text: "", color: AppColor.primaryBlack, font: Poppins.medium, size: 9, alignment: .center)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = AppColor.textGray
        layer.cornerRadius = 2
        layer.masksToBounds = true
        
        addSubview(title)
        title.centerInSuperview()
    }
    
    func configureCell(with data: SeatsModel) {
        title.text = data.seatNumber.title
        backgroundColor = data.isAvailable ? AppColor.appGreen : AppColor.textGray
        if data.userSelected { backgroundColor = AppColor.buttonPink }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
