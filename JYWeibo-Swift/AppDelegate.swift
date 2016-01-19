//
//  AppDelegate.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/19.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        window                     = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor    = UIColor.whiteColor()
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

