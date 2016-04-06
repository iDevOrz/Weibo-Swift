//
//  EmoticonViewController.swift
//  表情键盘界面布局
//
//  Created by 张建宇 on 16/3/3.
//  Copyright © 2016年 张建宇. All rights reserved.
//


import UIKit

private let JYEmoticonCellReuseIdentifier = "JYEmoticonCellReuseIdentifier"
class EmoticonViewController: UIViewController {
    
    var emoticonDidSelectedCallBack: (emoticon: Emoticon)->()
    
    init(callBack: (emoticon: Emoticon)->())
    {
        self.emoticonDidSelectedCallBack = callBack
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        setupUI()
    }

    private func setupUI()
    {
        view.addSubview(collectionVeiw)
        view.addSubview(toolbar)
        
        collectionVeiw.translatesAutoresizingMaskIntoConstraints = false
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        
        var cons = [NSLayoutConstraint]()
        let dict = ["collectionVeiw": collectionVeiw, "toolbar": toolbar]
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionVeiw]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[toolbar]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionVeiw]-[toolbar(44)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        
        view.addConstraints(cons)
    }
    
    func itemClick(item: UIBarButtonItem)
    {
        collectionVeiw.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: item.tag), atScrollPosition: UICollectionViewScrollPosition.Left, animated: true)
    }
    
    private lazy var collectionVeiw: UICollectionView = {
        let clv = UICollectionView(frame: CGRectZero, collectionViewLayout: EmoticonLayout())
        clv.backgroundColor = UIColor.whiteColor()
        clv.registerClass(EmoticonCell.self, forCellWithReuseIdentifier: JYEmoticonCellReuseIdentifier)
        clv.dataSource = self
        clv.delegate = self
        return clv
    }()
    
    private lazy var toolbar: UIToolbar = {
       let bar = UIToolbar()
        bar.tintColor = UIColor.darkGrayColor()
        var items = [UIBarButtonItem]()
        
        var index = 0
        for title in ["最近", "默认", "emoji", "浪小花"]
        {
            let item = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(EmoticonViewController.itemClick(_:)))
            item.tag = index + 1
            items.append(item)
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        bar.items = items
        return bar
    }()
    
    private lazy var packages: [EmoticonPackage] = EmoticonPackage.packageList
}

extension EmoticonViewController: UICollectionViewDataSource, UICollectionViewDelegate
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return packages.count
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return packages[section].emoticons?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionVeiw.dequeueReusableCellWithReuseIdentifier(JYEmoticonCellReuseIdentifier, forIndexPath: indexPath) as! EmoticonCell
        let package = packages[indexPath.section]
        let emoticon = package.emoticons![indexPath.item]
        cell.emoticon = emoticon
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let emoticon = packages[indexPath.section].emoticons![indexPath.item]
        emoticon.times += 1
        packages[0].appendEmoticons(emoticon)
        
        emoticonDidSelectedCallBack(emoticon: emoticon)
    }
}

class EmoticonCell: UICollectionViewCell {
    
    var emoticon: Emoticon?
        {
        didSet{
            if emoticon!.chs != nil
            {
                iconButton.setImage(UIImage(contentsOfFile: emoticon!.imagePath!), forState: UIControlState.Normal)
            }else
            {
                iconButton.setImage(nil, forState: UIControlState.Normal)
            }
            
            iconButton.setTitle(emoticon!.emojiStr ?? "", forState: UIControlState.Normal)
            
            if emoticon!.isRemoveButton
            {
                iconButton.setImage(UIImage(named: "compose_emotion_delete"), forState: UIControlState.Normal)
                iconButton.setImage(UIImage(named: "compose_emotion_delete_highlighted"), forState: UIControlState.Highlighted)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    private func setupUI()
    {
        contentView.addSubview(iconButton)
        iconButton.backgroundColor = UIColor.whiteColor()
        iconButton.frame = CGRectInset(contentView.bounds, 4, 4)
        iconButton.userInteractionEnabled = false
    }

    private lazy var iconButton: UIButton = {
       let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFontOfSize(32)
        return btn
    }()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EmoticonLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        
        let width = collectionView!.bounds.width / 7
        itemSize = CGSize(width: width, height: width)
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        collectionView?.pagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
        
        let y = (collectionView!.bounds.height - 3 * width) * 0.45
        collectionView?.contentInset = UIEdgeInsets(top: y, left: 0, bottom: y, right: 0)
        
    }
}
