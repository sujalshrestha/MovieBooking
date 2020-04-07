//
//  ShowTimeTableCell.swift
//  MovieBooking
//
//  Created by Sujal on 4/5/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ShowTimeTableCell: UITableViewCell {
    
    static let cellId = "showTimeCell"
    
    let title = UILabel(text: "", color: .white, font: Poppins.regular, size: 16)
    
    let timeCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .black
        return collection
    }()
    
    private let movieTimings = BehaviorRelay<[String]>.init(value: [String]())
    private let bag = DisposeBag()
    private var movieHallData: MovieHallModel?
    var onTimeClicked: ((MovieHallModel, String) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        selectionStyle = .none
        setupTitle()
        setupTimeCollection()
        setupCollectionView()
        observeCollectionViewEvents()
    }
    
    private func setupTitle() {
        addSubview(title)
        title.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 12, bottom: 0, right: 0))
    }
    
    private func setupTimeCollection() {
        addSubview(timeCollection)
        timeCollection.anchor(top: title.bottomAnchor, leading: title.leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 12))
        timeCollection.constraintHeight(constant: 40)
    }
    
    func configureCell(with data: MovieHallModel) {
        movieHallData = data
        title.text = data.audtiorium
        movieTimings.accept(data.showTime)
    }
    
    private func setupCollectionView() {
        timeCollection.dataSource = nil
        timeCollection.delegate = self
        timeCollection.register(MovieTimeCell.self, forCellWithReuseIdentifier: MovieTimeCell.cellId)
    }
    
    private func observeCollectionViewEvents() {
        movieTimings.bind(to: timeCollection.rx.items(cellIdentifier: MovieTimeCell.cellId, cellType: MovieTimeCell.self)) { row, model, cell in
            cell.configureCell(with: model)
        }.disposed(by: bag)
        
        timeCollection.rx.modelSelected(String.self).subscribe(onNext: { [weak self] selectedItem in
            guard let self = self else { return }
            guard let movieHallData = self.movieHallData else { return }
            self.onTimeClicked?(movieHallData, selectedItem)
        }).disposed(by: bag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowTimeTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 30)
    }
}
