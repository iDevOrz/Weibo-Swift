//
//  BaseTableViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/20.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController ,VisitorViewDelegate{

    var userIsLogin = false;
    
    var visitorView = VisitorView()
    override func loadView() {
        userIsLogin ? super.loadView() : setupVisitorView()
    }
    
    
    private func setupVisitorView(){
        visitorView.delegate = self
        view = visitorView
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .Plain, target: self, action: "registerBtnClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .Plain, target: self, action: "loginBtnDidClick")
        
    }
    
    func loginBtnDidClick(){
        print(__FUNCTION__)
    }
    
    func registerBtnClick(){
        print(__FUNCTION__)
    }

}
