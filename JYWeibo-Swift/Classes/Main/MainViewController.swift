//
//  MainViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/19.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = UIColor.orangeColor()
        
        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverViewController(), title: "广场", imageName: "tabbar_discover")
        addChildViewController(ProfileViewController(), title: "我", imageName: "tabbar_profile")
    }
    /**
     初始化子控制器
     
     - parameter childController: 子控制器
     - parameter title:           标题
     - parameter imageName:       图片名
     */
    private func addChildViewController(childController: UIViewController,title:String,imageName:String) {
        childController.tabBarItem.image = UIImage(named:imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        childController.title = title
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
    }

}
