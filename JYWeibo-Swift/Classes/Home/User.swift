//
//  User.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/2/1.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class User: NSObject {
    /// 用户ID
    var id: Int = 0
    /// 昵称
    var name: String?
    /// 用户头像url，50×50
    var profile_image_url: String?
    /// 是否认证, true是, false不是
    var verified: Bool = false
    /// 认证类型: -1：没有认证，0，认证用户，2,3,5: 企业认证，220: 达人
    var verified_type: Int = -1
    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    var properties = ["id", "name", "profile_image_url", "verified", "verified_type"]
    override var description: String {
        let dict = dictionaryWithValuesForKeys(properties)
        return "\(dict)"
    }
    
    
}
