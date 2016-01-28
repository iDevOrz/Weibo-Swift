//
//  HomeViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/19.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if !userIsLogin
        {
            visitorView.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "我是张建宇,这是我仿写的新浪微博客户端")
            return;
        }
        setupNav()
    }
    
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention", target: self, action: "leftItemClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop", target: self, action: "rightItemClick")
        
        let titleBtn = TitleButton()
        titleBtn.setTitle("Jatstar", forState: .Normal)
        titleBtn .addTarget(self, action: "titltBtnClick:", forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    func titltBtnClick(btn:TitleButton){
        btn.selected = !btn.selected
        let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
        let popoverVC = sb.instantiateInitialViewController()
        
        popoverVC?.transitioningDelegate = self
        popoverVC?.modalPresentationStyle = .Custom
        
        
        presentViewController(popoverVC!, animated: true, completion: nil)
        print(__FUNCTION__)
    }
    
    func leftItemClick(){
        print(__FUNCTION__)
    }
    
    func rightItemClick(){
        print(__FUNCTION__)
    }
    
    var isPresent:Bool = false

}


// MARK: - 自定义的弹出动画
extension HomeViewController: UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {
    
    

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        return PopoverPresentationController(presentedViewController:presented , presentingViewController: presenting)
        
    }
    
    /**
     视图展现时调用
     
     - parameter presented:  <#presented description#>
     - parameter presenting: <#presenting description#>
     - parameter source:     <#source description#>
     
     - returns: <#return value description#>
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        return self
    }
    
    /**
     视图消失时调用
     
     - parameter dismissed: <#dismissed description#>
     
     - returns: <#return value description#>
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false
        return self
    }
    
    // This is used for percent driven interactive transitions, as well as for container controllers that have companion animations that might need to
    // synchronize with the main animation.
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.5
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        if(isPresent){
        toView?.transform = CGAffineTransformMakeScale(1.0, 0)
        
        transitionContext.containerView()?.addSubview(toView!)
        
        toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            toView?.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                transitionContext.completeTransition(true)
        }
        
        
        }else{
    let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
    UIView.animateWithDuration(0.2, animations: { () -> Void in
    fromView?.transform = CGAffineTransformMakeScale(1.0, 0.01)
    }) { (_) -> Void in
    transitionContext.completeTransition(true)
    }
    
    }

}

}
