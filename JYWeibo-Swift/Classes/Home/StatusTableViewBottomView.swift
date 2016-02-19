//
//  StatusTableViewBottomView.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/9.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class StatusTableViewBottomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    
    private func setupUI()
    {
        backgroundColor = UIColor(white: 0.902, alpha: 0.5)
        
        addSubview(retweetBtn)
        addSubview(unlikeBtn)
        addSubview(commonBtn)
        
        retweetBtn.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(self)
            make.height.equalTo(self).offset(-3)
            make.width.equalTo(unlikeBtn.snp_width)
        }
        unlikeBtn.snp_makeConstraints { (make) -> Void in
            make.height.width.top.equalTo(retweetBtn)
            make.left.equalTo(retweetBtn.snp_right)
        }
        commonBtn.snp_makeConstraints { (make) -> Void in
            make.height.width.top.equalTo(unlikeBtn)
            make.left.equalTo(unlikeBtn.snp_right)
            make.right.equalTo(self)
        }
    }

    private lazy var retweetBtn: UIButton = UIButton.createButton("timeline_icon_retweet", title: "转发")
    
    private lazy var unlikeBtn: UIButton = UIButton.createButton("timeline_icon_unlike", title: "赞")
    
    private lazy var commonBtn: UIButton = UIButton.createButton("timeline_icon_comment", title: "评论")
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
