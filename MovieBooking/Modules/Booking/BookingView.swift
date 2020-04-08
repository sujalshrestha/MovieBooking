//
//  BookingView.swift
//  MovieBooking
//
//  Created by Sujal on 4/5/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class BookingView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let bookingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsVerticalScrollIndicator = false
        collection.backgroundColor = .black
        return collection
    }()
    
    var collectionHeight: NSLayoutConstraint?
    
    lazy var unavailableSeat = getSeatView(color: AppColor.textGray, title: "Unavailable")
    lazy var availableSeat = getSeatView(color: AppColor.appGreen, title: "Available")
    lazy var selectedSeat = getSeatView(color: AppColor.buttonPink, title: "Selected")
    
    lazy var seatStack = HorizontalStackView(arrangedSubViews: [unavailableSeat, availableSeat, selectedSeat], spacing: 8, distribution: .fillEqually)
    
    let toolBar = BookingToolbar()
    
    private func getSeatView(color: UIColor, title: String) -> UIView {
        let view = UIView(color: color)
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        let titleLabel = UILabel(text: title, color: AppColor.primaryBlack, font: Poppins.medium, size: 9, numberOfLines: 0, alignment: .center)
        view.addSubview(titleLabel)
        titleLabel.centerInSuperview()
        view.constraintHeight(constant: 30)
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupScrollView()
        setupBookingCollection()
        setupSeatInfoStack()
        setupToolbar()
    }
    
    private func setupScrollView() {
        scrollView.maximumZoomScale = 1.5
        scrollView.minimumZoomScale = 1.0
        addSubview(scrollView)
        scrollView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        scrollView.addSubview(contentView)
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupBookingCollection() {
        contentView.addSubview(bookingCollection)
        bookingCollection.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        collectionHeight = bookingCollection.heightAnchor.constraint(equalToConstant: 300)
        collectionHeight?.isActive = true
    }
    
    private func setupSeatInfoStack() {
        contentView.addSubview(seatStack)
        seatStack.anchor(top: bookingCollection.bottomAnchor, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 14, left: 20, bottom: 30, right: 20))
    }
    
    private func setupToolbar() {
        addSubview(toolBar)
        toolBar.anchor(top: nil, leading: leadingAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        toolBar.constraintHeight(constant: 170)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let height = bookingCollection.contentSize.height
        if height > 0 { collectionHeight?.constant = bookingCollection.contentSize.height }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
