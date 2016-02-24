//
//  PhotoBrowserController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/24.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

private let JYPhotoBrowserCellReuseIdentifier = "JYPhotoBrowserCellReuseIdentifier"

class PhotoBrowserController: UIViewController {

    var currentIndex: Int?
    var pictureURLs: [NSURL]?
    init(index: Int, urls: [NSURL])
    {
        currentIndex = index
        pictureURLs = urls
        
        super.init(nibName: nil, bundle: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setupUI()
    }
    
    private func setupUI(){
        
        view.addSubview(collectionView)
        view.addSubview(closeBtn)
        view.addSubview(saveBtn)
        
        closeBtn.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(view).offset(-10)
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        
        saveBtn.snp_makeConstraints { (make) -> Void in
            make.size.equalTo(closeBtn)
            make.left.equalTo(view).offset(10)
            make.bottom.equalTo(view).offset(-10)
            
        }
        collectionView.frame = UIScreen.mainScreen().bounds
        collectionView.dataSource = self
        collectionView.registerClass(PhotoBrowserCell.self, forCellWithReuseIdentifier: JYPhotoBrowserCellReuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func close()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func save()
    {
        let index = collectionView.indexPathsForVisibleItems().last!
        let cell = collectionView.cellForItemAtIndexPath(index) as! PhotoBrowserCell
        let image = cell.iconView.image
        UIImageWriteToSavedPhotosAlbum(image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    }
    func image(image:UIImage, didFinishSavingWithError error:NSError?, contextInfo:AnyObject){
        if error != nil
        {
           // TODO 
            print("保存失败")
            
        }else
        {

            print("保存成功")
        }
    }
    
    
    private lazy var closeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("关闭", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.darkGrayColor()
        
        btn.addTarget(self, action: "close", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    private lazy var saveBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("保存", forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        btn.backgroundColor = UIColor.darkGrayColor()
        
        btn.addTarget(self, action: "save", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: PhotoBrowserLayout())
}

extension PhotoBrowserController : UICollectionViewDataSource, PhotoBrowserCellDelegate
{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureURLs?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(JYPhotoBrowserCellReuseIdentifier, forIndexPath: indexPath) as! PhotoBrowserCell
        
        cell.imageURL = pictureURLs![indexPath.item]
        cell.photoBrowserCellDelegate = self
        
        return cell
    }
    
    func photoBrowserCellDidClose(cell: PhotoBrowserCell) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

class PhotoBrowserLayout : UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        itemSize = UIScreen.mainScreen().bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
        collectionView?.bounces =  false
    }
}
