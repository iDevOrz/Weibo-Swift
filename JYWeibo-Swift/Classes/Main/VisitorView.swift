//
//  VisitorView.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/20.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
import SnapKit

class VisitorView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        addSubview(homeIcon)
        addSubview(messageLabel)
        addSubview(loginButton)
        addSubview(registerButton)
        
        //使用SnapKit自动布局子控件
        iconView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        homeIcon.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
        }
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView.snp_bottom)
            make.centerX.equalTo(self)
            make.left.equalTo(self).offset(40)
            make.right.equalTo(self).offset(-40)
        }
        registerButton .snp_makeConstraints { (make) -> Void in
            make.top.equalTo(messageLabel.snp_bottom)
            make.left.equalTo(messageLabel.snp_left)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        loginButton .snp_makeConstraints { (make) -> Void in
            make.top.equalTo(messageLabel.snp_bottom)
            make.right.equalTo(messageLabel.snp_right)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 转盘
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return imageView
    }()
    
    /// 图标
    private lazy var homeIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return image
    }()
    
    /// 文本
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "我是张建宇,这是我仿写的新浪微博项目,用来学习Swift2.0,后面的文字是用来测试换行的~"
        label.textColor = UIColor.grayColor()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("登陆", forState: .Normal)
        loginButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        loginButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        return loginButton
    }()
    
    private lazy var registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.setTitle("注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        registerButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        return registerButton
    }()
    
    
    
}
