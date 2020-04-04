//
//  BaseCollectionViewController.swift
//  MovieBooking
//
//  Created by Sujal on 4/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

class BaseCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.font(with: 16, family: Poppins.bold), NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
