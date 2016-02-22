//
//  HomeRefreshControl.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/22.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class HomeRefreshControl: UIRefreshControl {
    
    override init() {
        super.init()
        
        setupUI()
    }
    
    private func setupUI()
    {
        addSubview(refreshView)
        
        refreshView.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self)
            make.width.equalTo(170)
            make.height.equalTo(60)
        }

        addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    private var rotationArrowFlag = false
    private var loadingViewAnimFlag = false
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if frame.origin.y >= 0
        {
            return
        }
        
        if refreshing && !loadingViewAnimFlag
        {
            loadingViewAnimFlag = true
            refreshView.startLoadingViewAnim()
            return
        }
        
        if frame.origin.y >= -50 && rotationArrowFlag
        {
            rotationArrowFlag = false
            refreshView.rotaionArrowIcon(rotationArrowFlag)
        }else if frame.origin.y < -50 && !rotationArrowFlag
        {
            rotationArrowFlag = true
            refreshView.rotaionArrowIcon(rotationArrowFlag)
        }
    }
    
    override func endRefreshing() {
        super.endRefreshing()
        refreshView.stopLoadingViewAnim()
        loadingViewAnimFlag = false
    }
    
    private lazy var refreshView : HomeRefreshView =  HomeRefreshView()
    
    
    deinit
    {
        removeObserver(self, forKeyPath: "frame")
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class HomeRefreshView: UIView
{
    lazy var arrowIcon: UIImageView! = UIImageView(image: UIImage(named: "tableview_pull_refresh"))
    
    lazy var tipView: UIView! = UIView()
    
    lazy var loadingView: UIImageView! = UIImageView(image: UIImage(named: "tableview_pull_refresh@2x副本"))
    private var loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "正在刷新~~~"
        return label
    }()
    
    func rotaionArrowIcon(flag: Bool)
    {
        var angle = M_PI
        angle += flag ? -0.01 : 0.01
        UIView.animateWithDuration(0.2) { () -> Void in
            self.arrowIcon.transform = CGAffineTransformRotate(self.arrowIcon.transform, CGFloat(angle))
        }
    }
    
    func startLoadingViewAnim()
    {
        tipView.hidden = true
        
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.duration = 1
        anim.repeatCount = MAXFLOAT
        anim.removedOnCompletion = false
        loadingView.layer.addAnimation(anim, forKey: nil)
    }
    
    func stopLoadingViewAnim()
    {
        tipView.hidden = false
        
        loadingView.layer.removeAllAnimations()
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loadingView)
        addSubview(loadingLabel)
        addSubview(tipView)
        
        self.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(170)
            make.width.equalTo(60)
        }
        
        loadingView.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(32)
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(8)
        }
        
        loadingLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(loadingView.snp_right).offset(8)
            make.top.bottom.equalTo(self)
            make.right.equalTo(self)
        }
        
        tipView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.left.right.equalTo(self)
        }
        
    }
    
    private func createTipView() ->UIView{
        let view = UIView()
        let loadingLabel = UILabel()
        loadingLabel.text = "下拉刷新~~~"
        view.addSubview(arrowIcon)
        view.addSubview(loadingLabel)
        
        arrowIcon.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(32)
            make.centerY.equalTo(view)
            make.left.equalTo(view).offset(8)
        }
        
        loadingLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(arrowIcon.snp_right).offset(8)
            make.top.bottom.equalTo(view)
            make.right.equalTo(view)
        }
        return view
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
