//
//  TicketsView.swift
//  MovieBooking
//
//  Created by Sujal on 4/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class TicketsView: UIView {
    
    let title = UILabel(text: "You have purchased your tickets. Please find it below.", color: .white, font: Poppins.medium, size: 18, numberOfLines: 0, alignment: .center)
    
    let ticketCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .black
        collection.isPagingEnabled = true
        return collection
    }()
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.tintColor = .white
        control.currentPage = 0
        control.currentPageIndicatorTintColor = .white
        control.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        control.layer.cornerRadius = 8
        control.layer.masksToBounds = true
        control.hidesForSinglePage = true
        return control
    }()
        
    var pageControlWidth: NSLayoutConstraint?
    
    let doneButton = UIButton(title: "Done", titleColor: .white, backgroundColor: AppColor.appGreen, font: Poppins.medium, fontSize: 15, cornerRadius: 5)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        setupTitle()
        setupTickets()
        setupPageControl()
        setupDoneButton()
    }
    
    private func setupTitle() {
        addSubview(title)
        title.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
    }
    
    private func setupTickets() {
        addSubview(ticketCollection)
        ticketCollection.anchor(top: title.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        ticketCollection.constraintHeight(constant: 200)
    }
    
    private func setupPageControl() {
        addSubview(pageControl)
        pageControl.anchor(top: ticketCollection.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 10, right: 0))
        pageControl.constraintHeight(constant: 20)
        pageControl.centerXInSuperview()
    
        pageControlWidth = pageControl.widthAnchor.constraint(equalToConstant: 40)
        pageControlWidth?.isActive = true
    }
    
    private func setupDoneButton() {
        addSubview(doneButton)
        doneButton.anchor(top: pageControl.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 30, left: 20, bottom: 0, right: 20))
        doneButton.constraintHeight(constant: 44)
    }
    
    func handlePageCount(count: Int) {
        pageControl.numberOfPages = count
        let pageWidth = pageControl.size(forNumberOfPages: count)
        pageControlWidth?.constant = pageWidth.width + CGFloat(20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
