//
//  AppDelegate.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/19.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

let JYSwitchRootViewControllerKey = "JYSwitchRootViewControllerKey"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.switchRootViewController(_:)), name: JYSwitchRootViewControllerKey, object: nil)
        
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = defaultContoller()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func switchRootViewController(notify: NSNotification){
        if notify.object as! Bool
        {
            window?.rootViewController = MainViewController()
        }else
        {
            window?.rootViewController = WelcomeViewController()
        }
    }
    
    private func defaultContoller() ->UIViewController
    {
        if UserAccount.userLogin(){
            return isNewupdate() ? NewfeatureCollectionViewController() : WelcomeViewController()
        }
        return MainViewController()
    }
    
    private func isNewupdate() -> Bool{
        
        let currentVersion = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String

        let sandboxVersion =  NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String ?? "1.0"

        if currentVersion.compare(sandboxVersion) == NSComparisonResult.OrderedDescending
        {
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: "CFBundleShortVersionString")
            return true
        }
        
        return false
    }
}

