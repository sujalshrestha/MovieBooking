//
//  SeatsModel.swift
//  MovieBooking
//
//  Created by Sujal on 4/5/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation

struct SeatsModel {
    let id: String
    let seatNumber: SeatsRowData
    let isAvailable: Bool
    var userSelected: Bool
}

struct SeatsRowData {
    let title: String
    let price: Double
}

struct SeatsManager {
    private var data = [SeatsModel]()
    private var row = [SeatsRowData]()
    
    init() {
        getRowData()
        
        for seat in row {
            for index in 1...12 {
                let title = "\(seat.title) \(index)"
                let isAvailable = Bool.random()
                let seatRow = SeatsRowData(title: title, price: seat.price)
                data.append(SeatsModel(id: UUID().uuidString, seatNumber: seatRow, isAvailable: isAvailable, userSelected: false))
            }
        }
    }
    
    private mutating func getRowData() {
        row.append(SeatsRowData(title: "A", price: 440))
        row.append(SeatsRowData(title: "B", price: 440))
        row.append(SeatsRowData(title: "C", price: 340))
        row.append(SeatsRowData(title: "D", price: 340))
        row.append(SeatsRowData(title: "E", price: 340))
        row.append(SeatsRowData(title: "F", price: 340))
        row.append(SeatsRowData(title: "G", price: 340))
        row.append(SeatsRowData(title: "H", price: 340))
        row.append(SeatsRowData(title: "I", price: 340))
        row.append(SeatsRowData(title: "J", price: 340))
        row.append(SeatsRowData(title: "K", price: 340))
        row.append(SeatsRowData(title: "L", price: 340))
        row.append(SeatsRowData(title: "M", price: 340))
        row.append(SeatsRowData(title: "N", price: 340))
    }
    
    func getData() -> [SeatsModel] {
        return data
    }
    
    mutating func setUserSelection(index: Int) {
        data[index].userSelected.toggle()
    }
}
