//
//  PhotoBrowserCell.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/24.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
import Kingfisher


protocol PhotoBrowserCellDelegate : NSObjectProtocol
{
    func photoBrowserCellDidClose(cell: PhotoBrowserCell)
}

class PhotoBrowserCell: UICollectionViewCell {
    
    
    weak var photoBrowserCellDelegate : PhotoBrowserCellDelegate?
    var imageURL: NSURL?
        {
        didSet{
            reset()
            activity.startAnimating()
            iconView.kf_setImageWithURL(imageURL!, placeholderImage: nil, optionsInfo: nil) { (image, error, cacheType, imageURL) -> () in
                self.activity.stopAnimating()
                
                self.setImageViewPostion()
            }
        }
    }

    private func reset()
    {
        scrollview.contentInset = UIEdgeInsetsZero
        scrollview.contentOffset = CGPointZero
        scrollview.contentSize = CGSizeZero
        
        iconView.transform = CGAffineTransformIdentity
    }
    
    private func setImageViewPostion()
    {
        let size = self.displaySize(iconView.image!)
        if size.height < UIScreen.mainScreen().bounds.height
        {
            iconView.frame = CGRect(origin: CGPointZero, size: size)
            let y = (UIScreen.mainScreen().bounds.height - size.height) * 0.5
            self.scrollview.contentInset = UIEdgeInsets(top: y, left: 0, bottom: y, right: 0)
        }else
        {
            iconView.frame = CGRect(origin: CGPointZero, size: size)
            scrollview.contentSize = size
        }
    }

    private func displaySize(image: UIImage) -> CGSize
    {
        let scale = image.size.height / image.size.width
        let width = UIScreen.mainScreen().bounds.width
        let height =  width * scale
        
        return CGSize(width: width, height: height)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI()
    {
        contentView.addSubview(scrollview)
        scrollview.addSubview(iconView)
        contentView.addSubview(activity)
        
        scrollview.frame = UIScreen.mainScreen().bounds
        activity.center = contentView.center
        
        scrollview.delegate = self
        scrollview.maximumZoomScale = 2.0
        scrollview.minimumZoomScale = 0.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(PhotoBrowserCell.close))
        iconView.addGestureRecognizer(tap)
        iconView.userInteractionEnabled = true
        
        
    }
    
    func close()
    {
        print("close")
        photoBrowserCellDelegate?.photoBrowserCellDidClose(self)
    }
    
    private lazy var scrollview: UIScrollView = UIScrollView()
    lazy var iconView: UIImageView = UIImageView()
    private lazy var activity: UIActivityIndicatorView =  UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PhotoBrowserCell: UIScrollViewDelegate
{
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView?
    {
        return iconView
    }
    
    func scrollViewDidEndZooming(scrollView: UIScrollView, withView view: UIView?, atScale scale: CGFloat) {
        print("scrollViewDidEndZooming")
        var offsetX = (UIScreen.mainScreen().bounds.width - view!.frame.width) * 0.5
        var offsetY = (UIScreen.mainScreen().bounds.height - view!.frame.height) * 0.5
        offsetX = offsetX < 0 ? 0 : offsetX
        offsetY = offsetY < 0 ? 0 : offsetY
        
        scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: offsetY, right: offsetX)
    }
}
