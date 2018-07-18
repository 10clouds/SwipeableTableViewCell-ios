//
//  AppDelegate.swift
//  swipeable-cell-actions
//
//  Created by Kamil Powałowski on 12.07.2018.
//  Copyright © 2018 10Clouds. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let tableViewController = TableViewController()
        let navigationController = UINavigationController(rootViewController: tableViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}

