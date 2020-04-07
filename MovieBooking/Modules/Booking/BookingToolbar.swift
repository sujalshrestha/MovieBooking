//
//  BookingToolbar.swift
//  MovieBooking
//
//  Created by Sujal on 4/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class BookingToolbar: UIView {
    
    let movieName = UILabel(text: "", color: AppColor.primaryBlack, font: Poppins.medium, size: 14)
    let auditorium = UILabel(text: "", color: AppColor.textGray, font: Poppins.regular, size: 14)
    let seatsPicked = UILabel(text: "", color: AppColor.primaryBlack, font: Poppins.regular, size: 13, numberOfLines: 0)
    let price = UILabel(text: "Rs. 0", color: AppColor.buttonBlue, font: Poppins.bold, size: 16)
    
    lazy var infoStack = VerticalStackView(arrangedSubViews: [movieName, auditorium, seatsPicked, price], spacing: 3)
    
    let proceed = UIButton(title: "Proceed", titleColor: .white, backgroundColor: AppColor.appGreen, font: Poppins.medium, fontSize: 14, cornerRadius: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupToolbar()
        setupInfoView()
        setupButtonView()
    }
    
    private func setupToolbar() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    private func setupInfoView() {
        addSubview(infoStack)
        infoStack.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 12, bottom: 0, right: 12))
    }
    
    private func setupButtonView() {
        addSubview(proceed)
        proceed.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 15, right: 20))
        proceed.constraintHeight(constant: 40)
    }
    
    func configureView(with data: ShowTimeModel) {
        movieName.text = data.movieName
        auditorium.text = data.hallName + " | " + data.time
    }
    
    func configureSeat(seatData: [String], amount: Double) {
        let seats = seatData.joined(separator:", ")
        seatsPicked.text = "Seats: \(seats)"
        price.text = "Rs. \(amount)"
    }
    
    func configureButton(isSelected: Bool) {
        proceed.isEnabled = isSelected
        proceed.backgroundColor = isSelected ? AppColor.appGreen : AppColor.textGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
