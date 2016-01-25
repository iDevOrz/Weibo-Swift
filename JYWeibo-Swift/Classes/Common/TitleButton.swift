//
//  TitleButton.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/25.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class TitleButton: UIButton {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        setImage(UIImage(named:"navigationbar_arrow_down"), forState: .Normal)
        setImage(UIImage(named:"navigationbar_arrow_up"), forState: .Selected)
        sizeToFit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width
    }

}
