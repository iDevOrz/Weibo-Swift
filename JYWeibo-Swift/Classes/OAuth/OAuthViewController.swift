//
//  OAuthViewController.swift
//  JYWeibo-Swift
//
//  Created by 张建宇 on 16/1/30.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
import Alamofire

class OAuthViewController: UIViewController {
    
    let App_Key = "2052279662"
    let App_Secret = "f1adc71a34deeabb3acd7d99717f8e6c"
    let App_Redirect_Uri = "http://jatstar.cn"
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Jatstar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: .Plain, target: self, action: "close")
        
        /// SSL 不是1.2版本 http://stackoverflow.com/questions/30927368/nsurlsession-nsurlconnection-http-load-failed-kcfstreamerrordomainssl-9802
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(App_Key)&redirect_uri=\(App_Redirect_Uri)"
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)
        
    }
    
    func close(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    private lazy var webView: UIWebView = {
        let webView = UIWebView()
        webView.delegate = self
        return webView
    }()

}

extension OAuthViewController: UIWebViewDelegate {
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool{
        if request.URL!.absoluteString.hasPrefix(App_Redirect_Uri+"/?code="){
           let arr = request.URL?.query?.componentsSeparatedByString("=")
           loadAccessToken(arr!.last!)
           return false
        }
        return true
    }
    
    private func loadAccessToken(code:String){
        /*
        必选	类型及范围	说明
        client_id	true	string	申请应用时分配的AppKey。
        client_secret	true	string	申请应用时分配的AppSecret。
        grant_type	true	string	请求的类型，填写authorization_code
        
        grant_type为authorization_code时
        必选	类型及范围	说明
        code	true	string	调用authorize获得的code值。
        redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
        */
        
        let parameters = ["client_id":App_Key,"client_secret":App_Secret,"grant_type":"authorization_code","code":code,"redirect_uri":App_Redirect_Uri]
        Alamofire.request(.POST, "https://api.weibo.com/oauth2/access_token", parameters:parameters, encoding:.URL , headers: nil).responseJSON { (
            Response
            ) -> Void in
            
            let account = UserAccount(dict:Response.result.value  as! [String : AnyObject])
            account.loadUserInfo { (account, error) -> () in
                if account != nil
                {
                    account!.saveAccount()
                }
                
            }
        }
    }
}

