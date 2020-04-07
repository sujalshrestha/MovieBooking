//
//  TicketsCell.swift
//  MovieBooking
//
//  Created by Sujal on 4/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class TicketsCell: UICollectionViewCell {
    
    static let cellId = "ticketCell"
    
    let ticketId = UILabel(text: "", color: AppColor.textGray, font: Poppins.regular, size: 10, numberOfLines: 2)
    let movieName = UILabel(text: "", color: AppColor.primaryBlack, font: Poppins.medium, size: 14)
    let auditorium = UILabel(text: "", color: AppColor.textGray, font: Poppins.regular, size: 15)
    let time = UILabel(text: "", color: AppColor.textGray, font: Poppins.regular, size: 15)
    let seatNumber = UILabel(text: "", color: AppColor.primaryBlack, font: Poppins.medium, size: 13)
    let priceLabel = UILabel(text: "", color: AppColor.buttonBlue, font: Poppins.medium, size: 14)
    
    lazy var infoStack = VerticalStackView(arrangedSubViews: [ticketId, movieName, auditorium, time, seatNumber, priceLabel], spacing: 4, distribution: .fillEqually)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.masksToBounds = true
        addSubview(infoStack)
        infoStack.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    func configureCell(with seatData: SeatsModel, showData: ShowTimeModel) {
        ticketId.text = "Ticket Id: \(seatData.id)"
        movieName.text = "Movie: \(showData.movieName)"
        auditorium.text = "Auditorium: \(showData.hallName)"
        time.text = "Time: \(showData.time)"
        seatNumber.text = "Seat No: \(seatData.seatNumber.title)"
        priceLabel.text = "Price: Nrs. \(String(seatData.seatNumber.price))"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
