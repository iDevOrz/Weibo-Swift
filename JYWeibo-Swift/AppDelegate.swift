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
        
        print(UserAccount.loadAccount())
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchRootViewController:", name: JYSwitchRootViewControllerKey, object: nil)
        
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = defaultContoller()
        window?.makeKeyAndVisible()
        
        print(isNewupdate())
        
        return true
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func switchRootViewController(notify: NSNotification){
        //        print(notify.object)
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

        let sandboxVersion =  NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String ?? ""

        if currentVersion != sandboxVersion
        {
            //存储版本号
            NSUserDefaults.standardUserDefaults().setObject(currentVersion, forKey: "CFBundleShortVersionString")
            return true
        }
        
        return false
    }
}

