//
//  AppDelegate.swift
//  SwipeableTableViewCell
//
//  Created by Hubert Kuczynski on 09/10/2018.
//  Copyright (c) 2018 Hubert Kuczynski. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TableViewController()
        window?.makeKeyAndVisible()
        return true
    }
}
