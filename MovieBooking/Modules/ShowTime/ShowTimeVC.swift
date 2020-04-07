//
//  ShowTimeVC.swift
//  MovieBooking
//
//  Created by Sujal on 4/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class ShowTimeVC: BaseViewController {
    
    let baseView = ShowTimeView()
    let movieData: MovieListData
    
    let showTimeTable = ShowTimeTable()
    
    init(movieData: MovieListData) {
        self.movieData = movieData
        super.init(nibName: nil, bundle: nil)
        baseView.configureView(with: self.movieData)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        title = movieData.title ?? ""
        setupChildControllers()
        showTimeTable.movieListData = movieData
        observeChildEvents()
    }
    
    private func setupChildControllers() {
        add(showTimeTable, innerView: baseView.movieTableView)
        showTimeTable.view.fillSuperview()
    }
    
    private func observeChildEvents() {
        showTimeTable.onTableHeight = { [weak self] tableHeight in
            self?.baseView.movieTableHeight?.constant = tableHeight
        }
    }
    
    override func loadView() {
        view = baseView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
