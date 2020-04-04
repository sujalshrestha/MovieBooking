//
//  AppDelegate.swift
//  MovieBooking
//
//  Created by Sujal on 4/4/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window : UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: MovieListVC())
        return true
    }
}

