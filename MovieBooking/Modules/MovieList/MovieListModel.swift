//
//  MovieListModel.swift
//  MovieBooking
//
//  Created by Sujal on 4/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation

struct MovieListModel: DataModel {
    var errors: [String]?
    let results: [MovieListData]?
}

struct MovieListData: DataModel {
    var errors: [String]?
    let title: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
}
