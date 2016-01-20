//
//  BaseTableViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/20.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    var userIsLogin = false;
    
    override func loadView() {
        userIsLogin ? super.loadView() : setupVisitorView()
    }
    
    
    private func setupVisitorView(){
    let  visitorView = VisitorView()
    visitorView.backgroundColor = UIColor.whiteColor()
    view = visitorView
    }
}
