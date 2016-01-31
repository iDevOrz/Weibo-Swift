//
//  NewfeatureCollectionViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/31.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

private let newfeatureCellIdentifier = "NewfeatureCellIdentifier"

class NewfeatureCollectionViewController: UICollectionViewController {
    private let  pageCount = 4
    private var layout: UICollectionViewFlowLayout = NewfeatureLayout()
    init(){
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.registerClass(NewfeatureCell.self, forCellWithReuseIdentifier: newfeatureCellIdentifier)
    }
    
    
    // MARK: - UICollectionViewDataSource
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCount
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(newfeatureCellIdentifier, forIndexPath: indexPath) as! NewfeatureCell
        
        cell.imageIndex = indexPath.item
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        
        let path = collectionView.indexPathsForVisibleItems().last!
        print(path)
        if path.item == (pageCount - 1)
        {
            let cell = collectionView.cellForItemAtIndexPath(path) as! NewfeatureCell
            cell.startBtnAnimation()
        }
    }
}

class NewfeatureCell: UICollectionViewCell
{
    private var imageIndex:Int? {
        didSet{
            iconView.image = UIImage(named: "new_feature_\(imageIndex! + 1)")
        }
    }
    
    func startBtnAnimation()
    {
        startButton.hidden = false
        
        startButton.transform = CGAffineTransformMakeScale(0.0, 0.0)
        startButton.userInteractionEnabled = false
        
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            self.startButton.transform = CGAffineTransformIdentity
            }, completion: { (_) -> Void in
                self.startButton.userInteractionEnabled = true
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customBtnClick()
    {
        NSNotificationCenter.defaultCenter().postNotificationName(JYSwitchRootViewControllerKey, object: true)
    }
    
    private func setupUI(){
        contentView.addSubview(iconView)
        contentView.addSubview(startButton)
        
        iconView.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(contentView)
            make.center.equalTo(contentView)
        }
        startButton.snp_makeConstraints { (make) -> Void in
           make.centerX.equalTo(contentView)
            make.bottom.equalTo(contentView.snp_bottom).offset(-160)
        }
}
    
    private lazy var iconView = UIImageView()
    private lazy var startButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: UIControlState.Highlighted)
        
        btn.hidden = true
        btn.addTarget(self, action: "customBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
}

private class NewfeatureLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout()
    {
        itemSize = UIScreen.mainScreen().bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
    }
}