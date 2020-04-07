//
//  ShowTimeTable.swift
//  MovieBooking
//
//  Created by Sujal on 4/5/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShowTimeTable: UITableViewController {
    
    private let bag = DisposeBag()
    private let manager = MovieHallManager()
    private let movieData = BehaviorRelay<[MovieHallModel]>.init(value: [MovieHallModel]())
    var movieListData: MovieListData?
    var onTableHeight: ((CGFloat) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        obsereveTableViewEvents()
    }
    
    private func setupTableView() {
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .black
        tableView.tableFooterView = UIView()
        tableView.register(ShowTimeTableCell.self, forCellReuseIdentifier: ShowTimeTableCell.cellId)
        tableView.dataSource = nil
        tableView.rowHeight = 90
    }
    
    private func obsereveTableViewEvents() {
        let data = manager.getData()
        movieData.accept(data)
                
        movieData.bind(to: tableView.rx.items(cellIdentifier: ShowTimeTableCell.cellId, cellType: ShowTimeTableCell.self)) { row, model, cell in
            cell.configureCell(with: model)
            cell.onTimeClicked = { [weak self] (movieData, time) in
                guard let self = self else { return }
                let showModel = ShowTimeModel(hallName: movieData.audtiorium, movieName: self.movieListData?.title ?? "", time: time)
                self.gotoBooking(showData: showModel)
            }
        }.disposed(by: bag)
    }
    
    private func gotoBooking(showData: ShowTimeModel) {
        let bookingVC = BookingVC(showTime: showData)
        navigationController?.pushViewController(bookingVC, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let height = tableView.contentSize.height
        if height > 0 { onTableHeight?(height) }
    }
}
