//
//  TicketsVC.swift
//  MovieBooking
//
//  Created by Sujal on 4/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TicketsVC: UIViewController {
    
    let baseView = TicketsView()
    let viewModel: TicketsViewModel
    
    init(userSeats: [SeatsModel], showTimeData: ShowTimeModel) {
        viewModel = TicketsViewModel(bag: DisposeBag(), userSeats: userSeats, showData: showTimeData)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        observeCollectionViewEvents()
        observeEvents()
    }
    
    private func setupCollectionView() {
        title = "Tickets"
        baseView.ticketCollection.register(TicketsCell.self, forCellWithReuseIdentifier: TicketsCell.cellId)
        baseView.ticketCollection.dataSource = nil
        baseView.ticketCollection.delegate = self
    }
    
    private func observeCollectionViewEvents() {
        viewModel.seatsData.bind(to: baseView.ticketCollection.rx.items(cellIdentifier: TicketsCell.cellId, cellType: TicketsCell.self)) { [weak self] row, model, cell in
            guard let self = self else { return }
            cell.configureCell(with: model, showData: self.viewModel.showData)
        }.disposed(by: viewModel.bag)
    }
    
    private func observeEvents() {
        viewModel.seatsData.subscribe(onNext: { [weak self] tickets in
            self?.baseView.handlePageCount(count: tickets.count)
        }).disposed(by: viewModel.bag)
        
        baseView.doneButton.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.navigationController?.popToRootViewController(animated: true)
        }).disposed(by: viewModel.bag)
    }
    
    override func loadView() {
        view = baseView
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TicketsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let width = baseView.ticketCollection.frame.width
        let index = Int(x / width)
        baseView.pageControl.currentPage = index
    }
}
