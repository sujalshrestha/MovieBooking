//
//  MovieListViewModel.swift
//  MovieBooking
//
//  Created by Sujal on 4/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MovieListViewModel {
    
    let bag: DisposeBag
    private let apiClient: ApiClient
    let networkResponse = BehaviorRelay<NetworkResponse?>.init(value: nil)
    let moviesData = BehaviorRelay<[MovieListData]>.init(value: [MovieListData]())
    let showHud = BehaviorRelay<Bool?>.init(value: nil)
    
    init(bag: DisposeBag) {
        self.bag = bag
        self.apiClient = ApiClient(bag: self.bag)
    }
    
    func getMovies() {
        showHud.accept(true)
        
        apiClient.getMovies { [weak self] (response) in
            guard let self = self else { return }
            self.handleResponse(response: response)
        }
    }
    
    private func handleResponse(response: NetworkResponse) {
        showHud.accept(false)
        if !response.success {
            networkResponse.accept(response)
            return
        }
        guard let dataResponse = response.objects as? MovieListModel else { return }
        guard let movieData = dataResponse.results else { return }
        moviesData.accept(movieData)
    }
}
