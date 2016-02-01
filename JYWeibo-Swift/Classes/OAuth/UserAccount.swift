//
//  UserAccount.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/31.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
import Alamofire

class UserAccount: NSObject , NSCoding{
    var access_token: String?
    var expires_in: NSNumber?{
        didSet{
            //过期时间
            expires_Date = NSDate(timeIntervalSinceNow: expires_in!.doubleValue)
        }
    }
    
    var expires_Date: NSDate?
    
    var uid:String?
    
    var avatar_large: String?
    
    var screen_name: String?
    
    override init() {
        
    }
    
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
    }
    
    func loadUserInfo(finished: (account: UserAccount?, error:NSError?)->())
    {
        let params = ["access_token":access_token!, "uid":uid!]
        Alamofire.request(.GET, "https://api.weibo.com/2/users/show.json", parameters:params , encoding:.URLEncodedInURL , headers: nil).responseJSON { (
            Response
            ) -> Void in
            
            if let dict = Response.result.value as? [String: AnyObject]
            {
                self.screen_name = dict["screen_name"] as? String
                self.avatar_large = dict["avatar_large"] as? String
                finished(account: self, error: nil)
                return
            }else{
            
            finished(account: nil, error: Response.result.error)
            }
            
        }
            finished(account: nil, error:nil)
    }

    
    class func userLogin() -> Bool
    {
        return UserAccount.loadAccount() != nil
    }
    
    static let filePath = "account.plist".cacheDir()
    func saveAccount()
    {
        NSKeyedArchiver.archiveRootObject(self, toFile: UserAccount.filePath)
    }
    
    static var account: UserAccount?
    class func loadAccount() -> UserAccount? {
        if account != nil
        {
            return account
        }
        account =  NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? UserAccount
        
        if account?.expires_Date?.compare(NSDate()) == NSComparisonResult.OrderedAscending
        {
            // 过期
            return nil
        }
        
        return account
    }
    
    // MARK: - NSCoding
    // 归档
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeObject(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_Date, forKey: "expires_Date")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
    }
    // 解档
    required init?(coder aDecoder: NSCoder)
    {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
        expires_Date = aDecoder.decodeObjectForKey("expires_Date") as? NSDate
        screen_name = aDecoder.decodeObjectForKey("screen_name")  as? String
        avatar_large = aDecoder.decodeObjectForKey("avatar_large")  as? String
    }
}


