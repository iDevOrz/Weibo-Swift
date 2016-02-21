//
//  StatusForwardTableViewCell.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/21.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class StatusForwardTableViewCell: StatusTableViewCell {
    
    override var status: Status?
        {
        didSet{
            let name = status?.retweeted_status?.user?.name ?? ""
            let text = status?.retweeted_status?.text ?? ""
            forwardLabel.text = name + ": " + text
        }
    }
    
    override func setupUI() {
        super.setupUI()

        contentView.insertSubview(forwardButton, belowSubview: pictureView)
        contentView.insertSubview(forwardLabel, aboveSubview: forwardButton)
        forwardButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(10)
            make.right.left.equalTo(footerView)
            make.bottom.equalTo(footerView.snp_top)
        }
        
        forwardLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(forwardButton).offset(10)
            make.left.equalTo(forwardButton).offset(10)
            make.right.equalTo(forwardButton).offset(-10)
        }
        
        pictureView.snp_updateConstraints { (make) -> Void in
            make.top.equalTo(forwardLabel.snp_bottom).offset(10)
            make.left.equalTo(forwardLabel)
            
        }
    }
    
    private lazy var forwardLabel: UILabel = {
        let label = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 15)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return label
    }()
    
    private lazy var forwardButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        return btn
    }()
}
