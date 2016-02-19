//
//  UILabel+Category.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/9.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

extension UILabel{
    
    /// 快速创建UILabel
    class func createLabel(color: UIColor, fontSize: CGFloat) -> UILabel
    {
        let label = UILabel()
        label.textColor = color
        label.font = UIFont.systemFontOfSize(fontSize)
        return label
    }
}