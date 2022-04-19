//
//  AppDelegate.swift
//  GSMLayout
//
//  Created by ahnjh1028@naver.com on 04/14/2022.
//  Copyright (c) 2022 ahnjh1028@naver.com. All rights reserved.
//

import UIKit
import GSMLayout

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window!.rootViewController = UIViewController()
        window!.makeKeyAndVisible()

        return true
    }
}

