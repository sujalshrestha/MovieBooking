//
//  BookingVC.swift
//  MovieBooking
//
//  Created by Sujal on 4/5/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BookingVC: BaseViewController {
    
    let baseView = BookingView()
    let viewModel: BookingViewModel
    private let spacing: CGFloat = 5
    
    init(showTime: ShowTimeModel) {
        viewModel = BookingViewModel(bag: DisposeBag(), showData: showTime)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupCollectionView()
        observeCollectionViewEvents()
        observeEvents()
        setupRx()
        baseView.toolBar.configureView(with: viewModel.showData)
        baseView.scrollView.delegate = self
    }
    
    private func setupCollectionView() {
        title = "Pick your seat"
        baseView.bookingCollection.register(BookingCell.self, forCellWithReuseIdentifier: BookingCell.cellId)
        baseView.bookingCollection.dataSource = nil
        baseView.bookingCollection.delegate = self
    }
    
    private func setupBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
    }
    
    @objc func handleDone() {
        baseView.scrollView.zoomScale = 1.0
        baseView.toolBar.isHidden = false
        disableBarButton()
    }
    
    private func disableBarButton() {
        navigationItem.rightBarButtonItem = nil
    }
    
    private func observeCollectionViewEvents() {
        viewModel.seatsData.bind(to: baseView.bookingCollection.rx.items(cellIdentifier: BookingCell.cellId, cellType: BookingCell.self)) { row, model, cell in
            cell.configureCell(with: model)
        }.disposed(by: viewModel.bag)
        
        Observable.zip(baseView.bookingCollection.rx.itemSelected, baseView.bookingCollection.rx.modelSelected(SeatsModel.self))
            .bind{ [weak self] indexPath, model in
                guard let self = self else { return }
                self.viewModel.handleSeatSelection(seat: model, index: indexPath.item)
        }
        .disposed(by: viewModel.bag)
    }
    
    private func observeEvents() {
        viewModel.onSeatPriceData = { [weak self] (seatNumbers, amount) in
            self?.baseView.toolBar.configureSeat(seatData: seatNumbers, amount: amount)
        }
    }
    
    private func setupRx() {
        viewModel.isSeatSelected.subscribe(onNext: { [weak self] isSelected in
            guard let self = self else { return }
            self.baseView.toolBar.configureButton(isSelected: isSelected)
        }).disposed(by: viewModel.bag)
        
        baseView.toolBar.proceed.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.gotoTickets()
        }).disposed(by: viewModel.bag)
    }
    
    private func gotoTickets() {
        let selectedSeats = viewModel.seatsData.value.filter({ $0.userSelected })
        let ticketVc = TicketsVC(userSeats: selectedSeats, showTimeData: viewModel.showData)
        navigationController?.pushViewController(ticketVc, animated: true)
    }
    
    override func loadView() {
        view = baseView
    }
}

extension BookingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width) / 12) - spacing
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}

extension BookingVC: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return baseView.contentView
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        setupBarButton()
        baseView.toolBar.isHidden = true
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if scale == 1.0 {
            disableBarButton()
            baseView.toolBar.isHidden = false
        }
    }
}
