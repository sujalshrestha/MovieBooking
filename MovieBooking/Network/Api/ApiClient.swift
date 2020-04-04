//
//  LoginApi.swift
//  AeonIndia
//
//  Created by Sujal on 3/19/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ApiClient {
    
    let bag: DisposeBag
    let networkResponse = BehaviorRelay<NetworkResponse?>.init(value: nil)
    let networkManager: NetworkManager
    
    init(bag: DisposeBag) {
        self.bag = bag
        self.networkManager = NetworkManager(disposeBag: bag)
    }
    
    func getMovies(onComplete: @escaping (NetworkResponse) -> Void) {
        let params: Params = ["api_key": ApiConstants.key]
        
        networkManager.request(api: ApiRouter.getMovies(params), dataModel: MovieListModel.self)
            .subscribe(onNext: { response in
                onComplete(response)
            })
        .disposed(by: bag)
    }
}
