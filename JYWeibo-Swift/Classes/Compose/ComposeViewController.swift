//
//  ComposeViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/25.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
import Alamofire

class ComposeViewController: UIViewController {
    
    private lazy var emoticonVC: EmoticonViewController = EmoticonViewController { [unowned self] (emoticon) -> () in
        self.textView.insertEmoticon(emoticon)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ComposeViewController.keyboardChange(_:)), name:UIKeyboardWillChangeFrameNotification , object: nil)
        
        addChildViewController(emoticonVC)
        
        setupNav()
        setupInpuView()
        setupToolbar()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        textView.resignFirstResponder()
    }
    
    func keyboardChange(notify: NSNotification)
    {
        let value = notify.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        let rect = value.CGRectValue()
        
        toolbar.snp_updateConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.snp_bottom).offset(-rect.size.height)
        }
        let duration = notify.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        UIView.animateWithDuration(duration.doubleValue) { () -> Void in
            self.view.setNeedsLayout()
        }
    }
    
    private func setupInpuView()
    {
        view.addSubview(textView)
        textView.addSubview(placeholderLabel)
        
        textView.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(view)
            make.center.equalTo(view)
        }
        
        placeholderLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(textView).offset(10)
            make.left.equalTo(textView).offset(5)
        }
    }
    
    private func setupNav()
    {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ComposeViewController.dismissVC))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(ComposeViewController.sendStatus))
        navigationItem.rightBarButtonItem?.enabled = false
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 32))
        let sendLabel = UILabel()
        sendLabel.text = "发微博"
        sendLabel.font = UIFont.systemFontOfSize(15)
        sendLabel.sizeToFit()
        titleView.addSubview(sendLabel)
        
        let nameLabel = UILabel()
        nameLabel.text = UserAccount.loadAccount()?.screen_name
        nameLabel.font = UIFont.systemFontOfSize(13)
        nameLabel.textColor = UIColor.darkGrayColor()
        nameLabel.sizeToFit()
        titleView.addSubview(nameLabel)
        
        sendLabel.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(titleView)
            make.top.equalTo(titleView)
        }
        
        nameLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(titleView)
            make.centerX.equalTo(titleView)
        }
        navigationItem.titleView = titleView
    }
    
    private func setupToolbar()
    {
        view.addSubview(toolbar)

        var items = [UIBarButtonItem]()
        let itemSettings = [["imageName": "compose_toolbar_picture", "action": "selectPicture"],
            
            ["imageName": "compose_mentionbutton_background"],
            
            ["imageName": "compose_trendbutton_background"],
            
            ["imageName": "compose_emoticonbutton_background", "action": "inputEmoticon"],
            
            ["imageName": "compose_addbutton_background"]]
        for dict in itemSettings
        {
            
            let item = UIBarButtonItem(imageName: dict["imageName"]!, target: self, action: dict["action"])
            items.append(item)
            items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        toolbar.items = items
        
        toolbar.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(self.view)
            make.bottom.equalTo(self.view.snp_bottom)
            make.left.equalTo(self.view.snp_left)
            make.height.equalTo(44)
        }
    }
    
    func selectPicture()
    {
        print(#function)
    }

    func inputEmoticon()
    {
        textView.resignFirstResponder()
        
        // 2.设置inputView
        textView.inputView = (textView.inputView == nil) ? emoticonVC.view : nil
        
        // 3.从新召唤出键盘
        textView.becomeFirstResponder()
        
    }
    
    func dismissVC()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func sendStatus()
    {
        let url = "https://api.weibo.com/2/statuses/update.json"
        let params = ["access_token":UserAccount.loadAccount()?.access_token! , "status": textView.text]
        
        Alamofire.request(.POST, url, parameters: params, encoding: .URL, headers: nil).responseJSON { (Response) -> Void in
            if (Response.result.error != nil) {
                print("发送失败")
            }else{
                print("发送成功")
                print(Response.result.value)
            }
        }
    }

    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.delegate = self
        return tv
    }()
    
    private lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(13)
        label.textColor = UIColor.darkGrayColor()
        label.text = "分享新鲜事..."
        return label
    }()
    
    private lazy var toolbar: UIToolbar = UIToolbar()
}

extension ComposeViewController: UITextViewDelegate
{
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = textView.hasText()
        navigationItem.rightBarButtonItem?.enabled = textView.hasText()
    }
}
