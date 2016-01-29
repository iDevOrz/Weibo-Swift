//
//  PopoverAnimator.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/29.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

let JYPopoverAnimatorShowNotification = "JYPopoverAnimatorShowNotification"
let JYPopoverAnimatorDismissNotification = "JYPopoverAnimatorDismissNotification"

class PopoverAnimator: NSObject , UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning
{
    private var isPresent: Bool = false
    
    var presentFrame = CGRectZero
    
    // MARK: - UIViewControllerTransitioningDelegate
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?{
        let pc = PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
        pc.presentFrame = presentFrame
        return pc
    }
    
    /**
     返回负责提供 Modal 动画对象
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        NSNotificationCenter.defaultCenter().postNotificationName(JYPopoverAnimatorShowNotification, object: self)
        return self
    }
    
    /**
     返回负责 dismiss 动画对象
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = false
        NSNotificationCenter.defaultCenter().postNotificationName(JYPopoverAnimatorDismissNotification, object: self)
        return self
    }
    
    // MARK: - UIViewControllerAnimatedTransitioning
    /**
    返回动画时长
    
    :param: transitionContext 转场上下文, 提供了转场需要的参数
    
    :returns: 动画时长
    */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.5
    }
    
    /**
     转场动画实现
     
     :param: transitionContext 转场上下文, 提供了转场需要的参数
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        if isPresent
        {
            let toView =  transitionContext.viewForKey(UITransitionContextToViewKey)!
            transitionContext.containerView()?.addSubview(toView)
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                toView.transform = CGAffineTransformIdentity
                }) { (_) -> Void in
                    transitionContext.completeTransition(true)
            }
        }else
        {
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.01)
                }, completion: { (_) -> Void in
                    transitionContext.completeTransition(true)
            })
        }
    }
}
