//
//  MovieList.swift
//  MovieBooking
//
//  Created by Sujal on 4/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListVC: BaseCollectionViewController {
    
    let viewModel: MovieListViewModel
    private let spacing: CGFloat = 10
    
    init() {
        viewModel = MovieListViewModel(bag: DisposeBag())
        let layout = UICollectionViewFlowLayout()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovies()
        setupNavigationBar()
        setupCollectionView()
        observeNetworkEvents()
    }
    
    private func setupCollectionView() {
        title = AppConstants.appName
        collectionView.register(MovieListCell.self, forCellWithReuseIdentifier: MovieListCell.cellId)
        collectionView.dataSource = nil
    }
    
    private func observeNetworkEvents() {
        viewModel.showHud.subscribe(onNext: { [unowned self] showHud in
            guard let showHud = showHud else { return }
            showHud ? self.showHUD() : self.hideHUD()
        }).disposed(by: viewModel.bag)
        
        viewModel.networkResponse.subscribe(onNext: { [unowned self] response in
            guard let response = response else { return }
            if !response.success {
                AlertMessage.showBasicAlert(on: self, message: response.message)
            }
        }).disposed(by: viewModel.bag)
        
        viewModel.moviesData.bind(to: collectionView.rx.items(cellIdentifier: MovieListCell.cellId, cellType: MovieListCell.self)) { row, model, cell in
            cell.configureCell(with: model)
        }.disposed(by: viewModel.bag)
        
//        tableView.rx.modelSelected(StatisticsResponse.self).subscribe(onNext: { [weak self] selectedItem in
//            guard let self = self else { return }
//            let controller = DetailsVC(statisticData: selectedItem)
//            self.navigationController?.pushViewController(controller, animated: true)
//        }).disposed(by: viewModel.bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2)
        return CGSize(width: width, height: 300)
    }
}
