//
//  HomeViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/19.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !userIsLogin
        {
            visitorView.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "我是张建宇,这是我仿写的新浪微博客户端")
            return;
        }
        setupNav()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: JYPopoverAnimatorShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: JYPopoverAnimatorDismissNotification, object: nil)
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention", target: self, action: "leftItemClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop", target: self, action: "rightItemClick")
        
        let titleBtn = TitleButton()
        titleBtn.setTitle("Jatstar", forState: .Normal)
        titleBtn .addTarget(self, action: "titltBtnClick:", forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    func change(){
        let titleBtn = navigationItem.titleView as! TitleButton
        titleBtn.selected = !titleBtn.selected
    }
    
    func titltBtnClick(btn:TitleButton){
        let popoverVC = PopoverViewController()
        
        popoverVC.transitioningDelegate = popoverAnimator
        popoverVC.modalPresentationStyle = .Custom
        
        
        presentViewController(popoverVC, animated: true, completion: nil)
        print(__FUNCTION__)
    }
    
    private lazy var popoverAnimator = PopoverAnimator()
    
    func leftItemClick(){
        print(__FUNCTION__)
    }
    
    func rightItemClick(){
        print(__FUNCTION__)
       print(UserAccount.loadAccount())
    }
    
    var isPresent:Bool = false

}