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
    }
    
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention", target: self, action: "leftItemClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop", target: self, action: "rightItemClick")
        
        let titleBtn = TitleButton()
        titleBtn.setTitle("Jatstar", forState: .Normal)
        titleBtn .addTarget(self, action: "titltBtnClick:", forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    func titltBtnClick(btn:TitleButton){
        btn.selected = !btn.selected
        print(__FUNCTION__)
    }
    
    func leftItemClick(){
        print(__FUNCTION__)
    }
    
    func rightItemClick(){
        print(__FUNCTION__)
    }

}
