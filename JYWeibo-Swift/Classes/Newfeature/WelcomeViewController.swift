//
//  WelcomeViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/31.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
import Kingfisher


class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgIV)
        view.addSubview(iconView)
        view.addSubview(messageLabel)
        
        bgIV.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(view)
            make.center.equalTo(view)
        }
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(100)
            make.centerX.equalTo(view)
            make.top.equalTo(view.snp_top).offset(200)
        }
        
        messageLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(iconView.snp_bottom).offset(20)
            make.centerX.equalTo(view)
        }
        // 头像
        if let iconUrl = UserAccount.loadAccount()?.avatar_large
        {
            let url = NSURL(string: iconUrl)!
            iconView.kf_setImageWithURL(url)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in

             self.view.layoutIfNeeded()
            self.iconView.snp_updateConstraints(closure: { (make) -> Void in
                make.top.equalTo(self.view.snp_top).offset(100)
            })
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                UIView.animateWithDuration( 1.0, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                    self.messageLabel.alpha = 1.0
                    }, completion: { (_) -> Void in
                        NSNotificationCenter.defaultCenter().postNotificationName(JYSwitchRootViewControllerKey, object: true)
                })
        }
        
    }
    
    // MARK: -懒加载
    private lazy var bgIV: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    
    private lazy var iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "欢迎回来"
        label.sizeToFit()
        label.alpha = 0.0
        return label
    }()
}
