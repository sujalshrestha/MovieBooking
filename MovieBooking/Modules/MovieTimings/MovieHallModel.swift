//
//  MovieHallModel.swift
//  MovieBooking
//
//  Created by Sujal on 4/5/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation

struct MovieHallModel {
    let audtiorium: String
    let showTime: [String]
}

struct MovieHallManager {
    private var data = [MovieHallModel]()
    
    init() {
        data.append(MovieHallModel.init(audtiorium: "Hall 1", showTime: ["9:00am", "12:00pm", "3:00pm", "6:00pm"]))
        data.append(MovieHallModel.init(audtiorium: "Hall 2", showTime: ["9:30am", "12:30pm", "3:30pm", "6:30pm"]))
        data.append(MovieHallModel.init(audtiorium: "Hall 3", showTime: ["10:00am", "1:00pm", "4:00pm", "9:00pm"]))
        data.append(MovieHallModel.init(audtiorium: "Hall 4", showTime: ["11:00am", "2:00pm", "5:00pm"]))
    }
    
    func getData() -> [MovieHallModel] {
        return data
    }
}
