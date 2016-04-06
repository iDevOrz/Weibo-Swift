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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.change), name: JYPopoverAnimatorShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.change), name: JYPopoverAnimatorDismissNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeViewController.presentPhotoBrowserView(_:)), name: JYStatusPictureViewSelected, object: nil)
        
        tableView.registerClass(StatusNormalTableViewCell.self, forCellReuseIdentifier: StatusTableViewCellIdentifier.NormalCell.rawValue)
        tableView.registerClass(StatusForwardTableViewCell.self, forCellReuseIdentifier: StatusTableViewCellIdentifier.ForwardCell.rawValue)
        tableView.separatorStyle = .None
        
        refreshControl = HomeRefreshControl()
        refreshControl?.addTarget(self, action: #selector(HomeViewController.loadData), forControlEvents: UIControlEvents.ValueChanged)
        
        loadData()
    }
    
    func presentPhotoBrowserView(notify: NSNotification)
    {
        guard let indexPath = notify.userInfo![JYStatusPictureViewIndexKey] as? NSIndexPath else
        {
            print("indexPath为空")
            return
        }
        
        guard let urls = notify.userInfo![JYStatusPictureViewURLsKey] as? [NSURL] else
        {
            print("配图为空")
            return
        }
        
        // 1.创建图片浏览器
        let vc = PhotoBrowserController(index: indexPath.item, urls: urls)
        
        // 2.显示图片浏览器
        presentViewController(vc, animated: true, completion: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setupNav(){
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention", target: self, action: #selector(HomeViewController.leftItemClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop", target: self, action: #selector(HomeViewController.rightItemClick))
        
        let titleBtn = TitleButton()
        titleBtn.setTitle("Jatstar", forState: .Normal)
        titleBtn .addTarget(self, action: #selector(HomeViewController.titltBtnClick(_:)), forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    
    lazy var pullupRefreshFlag:Bool = false
    
    func loadData()
    {
        var since_id = statuses?.first?.id ?? 0
        
        var max_id = 0
        if pullupRefreshFlag
        {
            since_id = 0
            max_id = statuses?.last?.id ?? 0
        }
        
        Status.loadStatuses(since_id,max_id: max_id) { (models, error) -> () in
            
            self.refreshControl?.endRefreshing()
            
            if error != nil
            {
                return
            }
            if since_id > 0
            {
                self.statuses = models! + self.statuses!
                self.showNewStatusCount(models?.count ?? 0)
            }else if max_id > 0{
                self.statuses = self.statuses! + models!
//                print("加载更多")
                
            }else{
                self.statuses = models
            }
        }
    }
    
    private func showNewStatusCount(count : Int)
    {
        if count == 0{
//            print("没有新微博")
            return;
        }
        newStatusLabel.hidden = false
        newStatusLabel.text = "\(count)条新微博"
        
        UIView.animateWithDuration(1, animations: { () -> Void in
            self.newStatusLabel.transform = CGAffineTransformMakeTranslation(0, self.newStatusLabel.frame.height)
            
            }) { (_) -> Void in
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.newStatusLabel.transform = CGAffineTransformIdentity
                    }, completion: { (_) -> Void in
                        self.newStatusLabel.hidden = true
                })
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
    }
    
    /// 菜单栏动画
    private lazy var popoverAnimator = PopoverAnimator()
    
    /// 下拉刷新提醒
    private lazy var newStatusLabel: UILabel =
    {
        let label = UILabel()
        let height: CGFloat = 44
        label.frame =  CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: height)
        label.backgroundColor = UIColor.orangeColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
        label.hidden = true
        return label
    }()
    
    func leftItemClick(){
        print(#function)
    }
    
    func rightItemClick(){
        print(#function)
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
        
        let count = statuses?.count ?? 0
        if indexPath.row == (count - 5)
        {
            // 滚动即将触底时,加载更多数据
            pullupRefreshFlag = true
            loadData()
        }
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
