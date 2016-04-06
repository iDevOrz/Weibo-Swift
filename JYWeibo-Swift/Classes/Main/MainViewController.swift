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
        addChildViewControllers()
       
    }

    private func addChildViewControllers(){
        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")

        addChildViewController(UIViewController())
        addChildViewController(DiscoverViewController(), title: "广场", imageName: "tabbar_discover")
        addChildViewController(ProfileViewController(), title: "我", imageName: "tabbar_profile")
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let width = UIScreen.mainScreen().bounds.size.width / CGFloat(viewControllers!.count)
        let rect = CGRect(x: 0, y: 0, width: width, height: 49)
        composeButton.frame = CGRectOffset(rect, width * 2, 0)
        
    }
    
    func composeBtnClick(){
        let composeVC = ComposeViewController()
        let nav = UINavigationController(rootViewController: composeVC)
        presentViewController(nav, animated: true, completion: nil)
    }
    
    lazy private var composeButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        button.addTarget(self, action: #selector(MainViewController.composeBtnClick), forControlEvents:.TouchUpInside)
        button.addTarget(self, action: #selector(MainViewController.composeBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        self.tabBar.addSubview(button)
        return button
    }()

    private func addChildViewController(childController: UIViewController,title:String,imageName:String) {
        childController.tabBarItem.image = UIImage(named:imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        childController.title = title
        let nav = UINavigationController(rootViewController: childController)
        addChildViewController(nav)
    }

}
