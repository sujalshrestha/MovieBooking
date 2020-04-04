//
//  BaseViewController.swift
//  GoPrint-iOS
//
//  Created by Sujal on 12/8/19.
//  Copyright © 2019 Mac. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.font(with: 16, family: Poppins.bold)]
    }
}
