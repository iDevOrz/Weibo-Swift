//
//  VisitorView.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/20.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

protocol VisitorViewDelegate:NSObjectProtocol{
    
    func loginBtnDidClick()
    
    func registerBtnClick()

}
class VisitorView: UIView {
    
    weak var delegate:VisitorViewDelegate?
    
    
    /**
     访客界面配置
     
     - parameter isHome:    是否是首页
     - parameter imageName: 图片名
     - parameter message:   文字信息
     */
    func setupVisitorInfo(isHome:Bool,imageName:String,message:String){
        iconView.hidden = !isHome
        homeIcon.image = UIImage(named: imageName)
        messageLabel.text = message
        StartAnimation()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(iconView)
        addSubview(maskBackgroundView)
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
            make.width.equalTo(220)
        }
        registerButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(messageLabel.snp_bottom)
            make.left.equalTo(messageLabel.snp_left)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        loginButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(messageLabel.snp_bottom)
            make.right.equalTo(messageLabel.snp_right)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        maskBackgroundView.snp_makeConstraints { (make) -> Void in
            make.left.right.top.bottom.equalTo(self)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: 转盘
    private lazy var iconView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        return imageView
    }()
    
    //MARK: 图标
    private lazy var homeIcon: UIImageView = {
        let image = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        return image
    }()
    
    //MARK: 文本
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "我是张建宇,这是我仿写的新浪微博项目,用来学习Swift2.0"
        label.textColor = UIColor.grayColor()
        label.numberOfLines = 0
        label.textAlignment = .Center
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("登陆", forState: .Normal)
        loginButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        loginButton.addTarget(self, action: #selector(VisitorView.loginButtonClick), forControlEvents: .TouchUpInside)
        loginButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        return loginButton
    }()
    
    private lazy var registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.setTitle("注册", forState: .Normal)
        registerButton.setTitleColor(UIColor.orangeColor(), forState: .Normal)
        registerButton.addTarget(self, action: #selector(VisitorView.registerButtonClick), forControlEvents: .TouchUpInside)
        registerButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: .Normal)
        return registerButton
    }()
    
    
    private lazy var maskBackgroundView: UIImageView = {
        let maskView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        return maskView
    }()
    
    private func StartAnimation(){
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = M_PI * 2
        animation.duration = 20
        animation.repeatCount = MAXFLOAT
        
        animation.removedOnCompletion = false
        
        iconView.layer.addAnimation(animation, forKey: nil)
        
    }
    
    func registerButtonClick(){
        delegate?.registerBtnClick()
    }
    
    func loginButtonClick(){
        delegate?.loginBtnDidClick()
    }
    
}
