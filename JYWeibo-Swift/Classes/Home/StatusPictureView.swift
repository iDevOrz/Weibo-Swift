//
//  StatusPictureView.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/9.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
import Kingfisher

class StatusPictureView: UICollectionView {
    var status: Status?
        {
        didSet{
            reloadData()
        }
    }
    
    private var pictureLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
    init()
    {
        super.init(frame: CGRectZero, collectionViewLayout: pictureLayout)
        
        registerClass(PictureViewCell.self, forCellWithReuseIdentifier: JYPictureViewCellReuseIdentifier)
        dataSource = self
        pictureLayout.minimumInteritemSpacing = 5
        pictureLayout.minimumLineSpacing = 5
        
        backgroundColor = UIColor.clearColor()
    }
    
    
    func calculateImageSize() -> CGSize
    {
        let count = status?.storedPicURLS?.count
        if count == 0 || count == nil
        {
            return CGSizeZero
        }
        if count == 1
        {
            let key = status?.storedPicURLS!.first?.absoluteString
            let image = KingfisherManager.sharedManager.cache.retrieveImageInDiskCacheForKey(key!)
            
            pictureLayout.itemSize = image!.size
            return image!.size
        }
        let margin:CGFloat = 5.0
        if count == 4 || count == 2
        {
            let cellWidth: CGFloat = 90.0
            pictureLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            let viewWidth = cellWidth * 2 + margin
            return CGSize(width: viewWidth, height: viewWidth * CGFloat(count! / 4))
        }
        let rowNumber = (count! - 1) / 3 + 1
        let viewWidth = UIScreen.mainScreen().bounds.size.width - 2 * margin
        let viewHeight = viewWidth / 3 * CGFloat(rowNumber)
        let cellWidth = viewWidth/3 -  margin
        pictureLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        return CGSize(width: viewWidth, height: viewHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private class PictureViewCell: UICollectionViewCell {
        
        var imageURL: NSURL?
            {
            didSet{
                iconImageView.kf_setImageWithURL(imageURL!)
            }
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }
        
        private func setupUI()
        {
            contentView.addSubview(iconImageView)
            iconImageView.snp_makeConstraints { (make) -> Void in
                make.top.bottom.equalTo(contentView)
                make.right.left.equalTo(contentView)
            }
        }
        
        private lazy var iconImageView:UIImageView = UIImageView()
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}


extension StatusPictureView: UICollectionViewDataSource
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return status?.storedPicURLS?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(JYPictureViewCellReuseIdentifier, forIndexPath: indexPath) as! PictureViewCell
        
        cell.imageURL = status?.storedPicURLS![indexPath.item]
        
        return cell
    }
    
}
