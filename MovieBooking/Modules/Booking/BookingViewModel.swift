//
//  BookingViewModel.swift
//  MovieBooking
//
//  Created by Sujal on 4/5/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BookingViewModel {
    let bag: DisposeBag
    var manager = SeatsManager()
    let seatsData = BehaviorRelay<[SeatsModel]>.init(value: [SeatsModel]())
    let isSeatSelected = BehaviorRelay<Bool>.init(value: false)
    let showData: ShowTimeModel
    var onSeatPriceData: (([String], Double) -> Void)?

    init(bag: DisposeBag, showData: ShowTimeModel) {
        self.bag = bag
        self.showData = showData
        getData()
        observeUserSeat()
    }
    
    private func getData() {
        seatsData.accept(manager.getData())
    }
    
    private func observeUserSeat() {
        seatsData.subscribe(onNext: { [weak self] data in
            guard let self = self else { return }
            let selectedSeats = data.filter({ $0.userSelected })
            self.isSeatSelected.accept(!selectedSeats.isEmpty)
            self.setUserSeats(seatData: selectedSeats)
        }).disposed(by: bag)
    }
    
    private func setUserSeats(seatData: [SeatsModel]) {
        var seatNumbers = [String]()
        var amount: Double = 0
        seatData.forEach { (data) in
            seatNumbers.append(data.seatNumber.title)
            amount += amount + data.seatNumber.price
        }
        onSeatPriceData?(seatNumbers, amount)
    }
    
    func handleSeatSelection(seat: SeatsModel, index: Int) {
        if !seat.isAvailable { return }
        manager.setUserSelection(index: index)
        getData()
    }
}
