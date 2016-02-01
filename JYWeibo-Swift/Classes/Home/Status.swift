//
//  Status.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/1.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
import Alamofire

class Status: NSObject {
    /// 微博创建时间
    var created_at: String?
    /// 微博ID
    var id: Int = 0
    /// 微博内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 配图数组
    var pic_urls: [[String: AnyObject]]?
    /// 用户信息
    var user: User?
    
    class func loadStatuses(finished: (models:[Status]?, error:NSError?)->()){
        let params = ["access_token": UserAccount.loadAccount()!.access_token!]
        
        
        Alamofire.request(.GET, "https://api.weibo.com/2/statuses/home_timeline.json", parameters:params, encoding: .URL, headers: nil).responseJSON { (
            Response
            ) -> Void in
            if (Response.result.value != nil){
                let resultDic = Response.result.value as! [String:AnyObject]
                
                let models = dictToModel(resultDic["statuses"] as! [[String: AnyObject]])
            
                finished(models: models, error: Response.result.error)
            }
        }
        

    }
    
    class func dictToModel(list: [[String: AnyObject]]) -> [Status] {
        var models = [Status]()
        for dict in list
        {
            models.append(Status(dict: dict))
        }
        return models
    }
    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
        if "user" == key
        {
            user = User(dict: value as! [String : AnyObject])
            return
        }
        
        super.setValue(value, forKey: key)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    var properties = ["created_at", "id", "text", "source", "pic_urls"]
    override var description: String {
        let dict = dictionaryWithValuesForKeys(properties)
        return "\(dict)"
    }
}
