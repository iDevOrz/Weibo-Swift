//
//  PopoverViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/29.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
import SnapKit

class PopoverViewController: UIViewController ,UITableViewDataSource{

    var tabbleView = UITableView()
    let identifer:String = "customCell"
    override func viewDidLoad() {
        view.addSubview(backgroundImageView)
        view.addSubview(tabbleView)
        tabbleView.backgroundColor = UIColor.clearColor()
        tabbleView.separatorStyle = .None
        tabbleView.dataSource = self
        tabbleView.registerClass(UITableViewCell.self, forCellReuseIdentifier: identifer)
        tabbleView.rowHeight = 30
        
        backgroundImageView.snp_makeConstraints { (make) -> Void in
            make.top.bottom.left.right.equalTo(view)
        }
        tabbleView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(view.snp_left).offset(5)
            make.right.equalTo(view.snp_right).offset(-5)
            make.top.equalTo(view.snp_top).offset(15)
            make.bottom.equalTo(view.snp_bottom).offset(-10)
        }
        
    }
    
   lazy private var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "popover_background"))
        return imageView
    }()
    
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendGroup.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(identifer)!
        cell.textLabel!.text = friendGroup[indexPath.row]
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    /// 好友分组
    lazy var friendGroup: [String] = {
        return ["首页", "好友圈", "群微博", "我的微博","特别关注","我关注的iOS大牛"];
    }()

}
