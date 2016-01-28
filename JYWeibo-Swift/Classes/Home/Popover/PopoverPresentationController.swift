//
//  PopoverPresentationController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/28.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController:presentingViewController)
    }
    override func containerViewWillLayoutSubviews() {
        presentedView()?.frame = CGRectMake(100, 56, 200, 200)
        containerView?.insertSubview(coverView, atIndex: 0)
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
