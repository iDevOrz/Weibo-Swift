//
//  UIBarButtonItem+Category.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/25.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    class func creatBarButtonItem(imageName:String,target:AnyObject?,action:Selector) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }

    convenience init(imageName:String, target: AnyObject?, action: String?)
    {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        if action != nil
        {
            btn.addTarget(target, action: Selector(action!), forControlEvents: UIControlEvents.TouchUpInside)
        }
        btn.sizeToFit()
        self.init(customView: btn)
    }

}