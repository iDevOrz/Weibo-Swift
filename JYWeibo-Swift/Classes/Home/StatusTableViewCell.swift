//
//  StatusTableViewCell.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/9.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

let JYPictureViewCellReuseIdentifier = "JYPictureViewCellReuseIdentifier"

enum StatusTableViewCellIdentifier: String
{
    case NormalCell = "NormalCell"
    case ForwardCell = "ForwardCell"
    static func cellID(status: Status) ->String
    {
        return status.retweeted_status != nil ? ForwardCell.rawValue : NormalCell.rawValue
    }
}

class StatusTableViewCell: UITableViewCell {
    
    lazy var pictureSize: CGSize = CGSizeZero
    var status: Status?
        {
        didSet{
            topView.status = status
            contentLabel.text = status?.text
            pictureView.status = status?.retweeted_status != nil ? status?.retweeted_status :  status
            pictureSize = pictureView.calculateImageSize()
            pictureView.snp_updateConstraints { (make) -> Void in
                make.height.equalTo(pictureSize.height)
                make.width.equalTo(pictureSize.width)
            }
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI()
    {
        
        
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureView)
        contentView.addSubview(footerView)
        
        let width = UIScreen.mainScreen().bounds.width
        topView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(contentView)
            make.left.equalTo(contentView)
            make.width.equalTo(width)
            make.height.equalTo(60)
        }
        
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView.snp_bottom).offset(10)
            make.left.equalTo(topView.snp_left).offset(10)
            
        }
        
        
        footerView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(width)
            make.top.equalTo(pictureView.snp_bottom).offset(10)
            make.height.equalTo(44)
            make.left.equalTo(self.contentView.snp_left)
        }
    }

    func rowHeight(status: Status) -> CGFloat
    {
        self.status = status
        
        self.layoutIfNeeded()
        
        return CGRectGetMaxY(footerView.frame)
    }
    
    private lazy var topView: StatusTableViewTopView = StatusTableViewTopView()
    
    lazy var contentLabel: UILabel =
    {
        let label = UILabel.createLabel(UIColor.darkGrayColor(), fontSize: 15)
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.width - 20
        return label
    }()
    
    lazy var pictureView: StatusPictureView = StatusPictureView()
    
    lazy var footerView: StatusTableViewBottomView = StatusTableViewBottomView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
