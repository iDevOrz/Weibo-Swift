//
//  StatusNormalTableViewCell.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/21.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class StatusNormalTableViewCell: StatusTableViewCell {
    
    
    override func setupUI() {
        super.setupUI()
        pictureView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentLabel.snp_bottom).offset(10)
            make.left.equalTo(contentLabel.snp_left)
        }
        
    }
}
