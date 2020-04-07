//
//  TicketsViewModel.swift
//  MovieBooking
//
//  Created by Sujal on 4/7/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TicketsViewModel {
    let bag: DisposeBag
    let seatsData = BehaviorRelay<[SeatsModel]>.init(value: [SeatsModel]())
    let showData: ShowTimeModel

    init(bag: DisposeBag, userSeats: [SeatsModel], showData: ShowTimeModel) {
        self.bag = bag
        self.showData = showData
        seatsData.accept(userSeats)
    }
}
