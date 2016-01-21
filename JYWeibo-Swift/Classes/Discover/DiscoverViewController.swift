//
//  DiscoverViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/19.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class DiscoverViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !userIsLogin
        {
            visitorView.setupVisitorInfo(false, imageName: "visitordiscover_feed_image_house", message: "我是张建宇,这是我仿写的新浪微博客户端")
        }
    }


}
