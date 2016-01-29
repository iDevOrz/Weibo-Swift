//
//  PopoverPresentationController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/28.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.mainScreen().bounds.width

class PopoverPresentationController: UIPresentationController {
    
    var presentFrame = CGRectZero
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController:presentingViewController)
    }
    override func containerViewWillLayoutSubviews() {
        containerView?.insertSubview(coverView, atIndex: 0)
        coverView.frame = (containerView?.frame)!
        if presentFrame == CGRectZero{
            presentedView()?.frame = CGRect(x:(screenWidth-200)/2.0 , y: 56, width: 200, height: 200)
        }else
        {
            presentedView()?.frame = presentFrame
        }
    }
    
    //MARK: 蒙版
    private lazy var coverView: UIView = {
        let view = UIView()
        view.frame = UIScreen.mainScreen().bounds
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.1)
        let tap = UITapGestureRecognizer(target: self, action: "close")
        view.addGestureRecognizer(tap)
        return view
    }()
    
    func close(){
        presentedViewController.dismissViewControllerAnimated(true, completion: nil);
        
    }

}
