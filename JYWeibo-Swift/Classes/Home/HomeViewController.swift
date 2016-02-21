//
//  HomeViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/19.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class HomeViewController: BaseTableViewController {
    
    var statuses: [Status]?
        {
        didSet{
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if !userIsLogin
        {
            visitorView.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "我是张建宇,这是我仿写的新浪微博客户端")
            return;
        }
        setupNav()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: JYPopoverAnimatorShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "change", name: JYPopoverAnimatorDismissNotification, object: nil)
        
        tableView.registerClass(StatusNormalTableViewCell.self, forCellReuseIdentifier: StatusTableViewCellIdentifier.NormalCell.rawValue)
        tableView.registerClass(StatusForwardTableViewCell.self, forCellReuseIdentifier: StatusTableViewCellIdentifier.ForwardCell.rawValue)
        tableView.separatorStyle = .None
        
        loadData()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention", target: self, action: "leftItemClick")
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop", target: self, action: "rightItemClick")
        
        let titleBtn = TitleButton()
        titleBtn.setTitle("Jatstar", forState: .Normal)
        titleBtn .addTarget(self, action: "titltBtnClick:", forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    private func loadData()
    {
        Status.loadStatuses { (models, error) -> () in
            
            if error != nil
            {
                return
            }
            self.statuses = models
        }
    }
    
    func change(){
        let titleBtn = navigationItem.titleView as! TitleButton
        titleBtn.selected = !titleBtn.selected
    }
    
    func titltBtnClick(btn:TitleButton){
        let popoverVC = PopoverViewController()
        
        popoverVC.transitioningDelegate = popoverAnimator
        popoverVC.modalPresentationStyle = .Custom
        
        
        presentViewController(popoverVC, animated: true, completion: nil)
        print(__FUNCTION__)
    }
    
    private lazy var popoverAnimator = PopoverAnimator()
    
    func leftItemClick(){
        print(__FUNCTION__)
    }
    
    func rightItemClick(){
        print(__FUNCTION__)
       print(UserAccount.loadAccount())
    }


    var rowCache: [Int: CGFloat] = [Int: CGFloat]()
    
    override func didReceiveMemoryWarning() {
        rowCache.removeAll()
    }
}



extension HomeViewController
{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let status = statuses![indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusTableViewCellIdentifier.cellID(status), forIndexPath: indexPath) as! StatusTableViewCell
        cell.status = status
        return cell
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let status = statuses![indexPath.row]
        
        if let height = rowCache[status.id]
        {
            return height
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(StatusTableViewCellIdentifier.cellID(status)) as! StatusTableViewCell
        
        // 4.拿到对应行的行高
        let rowHeight = cell.rowHeight(status)
        
        rowCache[status.id] = rowHeight
        
        return rowHeight
    }
}
