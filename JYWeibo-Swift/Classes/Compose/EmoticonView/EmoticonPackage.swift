//
//  EmoticonPackage.swift
//  表情键盘界面布局
//
//  Created by 张建宇 on 16/3/3.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit
/*
结构:
1. 加载emoticons.plist拿到每组表情的路径

emoticons.plist(字典)  存储了所有组表情的数据
|----packages(字典数组)
        |-------id(存储了对应组表情对应的文件夹)

2. 根据拿到的路径加载对应组表情的info.plist
info.plist(字典)
|----id(当前组表情文件夹的名称)
|----group_name_cn(组的名称)
|----emoticons(字典数组, 里面存储了所有表情)
        |----chs(表情对应的文字)
        |----png(表情对应的图片)
        |----code(emoji表情对应的十六进制字符串)
*/
class EmoticonPackage: NSObject {
    var id: String?
    var group_name_cn : String?
    var emoticons: [Emoticon]?
    
    
    static let packageList:[EmoticonPackage] = EmoticonPackage.loadPackages()

    private class func loadPackages() -> [EmoticonPackage] {
        print("-------------")
        var packages = [EmoticonPackage]()
        let pk = EmoticonPackage(id: "")
        pk.group_name_cn = "最近"
        pk.emoticons = [Emoticon]()
        pk.appendEmtyEmoticons()
        packages.append(pk)
        
        
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        let dict = NSDictionary(contentsOfFile: path)!
        let dictArray = dict["packages"] as! [[String:AnyObject]]
        for d in dictArray
        {
            let package = EmoticonPackage(id: d["id"]! as! String)
            packages.append(package)
            package.loadEmoticons()
            package.appendEmtyEmoticons()
        }
        return packages
    }
    
    func loadEmoticons() {
        let emoticonDict = NSDictionary(contentsOfFile: infoPath("info.plist"))!
        group_name_cn = emoticonDict["group_name_cn"] as? String
        let dictArray = emoticonDict["emoticons"] as! [[String: String]]
        emoticons = [Emoticon]()
        var index = 0
        for dict in dictArray{
            
            if index == 20
            {
                emoticons?.append(Emoticon(isRemoveButton: true))
                index = 0
            }
            emoticons?.append(Emoticon(dict: dict, id: id!))
            index++
        }
    }
    
    func appendEmtyEmoticons()
    {
        let count = emoticons!.count % 21
        
        for _ in count..<20
        {
            emoticons?.append(Emoticon(isRemoveButton: false))
        }
        emoticons?.append(Emoticon(isRemoveButton: true))
    }
    
    func appendEmoticons(emoticon: Emoticon)
    {
        if emoticon.isRemoveButton
        {
            return
        }
        let contains = emoticons!.contains(emoticon)
        if !contains
        {
            emoticons?.removeLast()
            emoticons?.append(emoticon)
        }
        
        // 3.对数组进行排序
        var result = emoticons?.sort({ (e1, e2) -> Bool in
            return e1.times > e2.times
        })
        
        if !contains
        {
            result?.removeLast()
            result?.append(Emoticon(isRemoveButton: true))
        }
        
        emoticons = result
    }
    

    func infoPath(fileName: String) -> String {
        return (EmoticonPackage.emoticonPath().stringByAppendingPathComponent(id!) as NSString).stringByAppendingPathComponent(fileName)
    }
    class func emoticonPath() -> NSString{
        return (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent("Emoticons.bundle")
    }
    
    init(id: String)
    {
        self.id = id
    }
}

class Emoticon: NSObject {
    var chs: String?
    var png: String?
        {
        didSet{
            imagePath = (EmoticonPackage.emoticonPath().stringByAppendingPathComponent(id!) as NSString).stringByAppendingPathComponent(png!)
        }
    }
    var code: String?{
        didSet{
            let scanner = NSScanner(string: code!)
            
            var result:UInt32 = 0
            scanner.scanHexInt(&result)
            emojiStr = "\(Character(UnicodeScalar(result)))"
        }
    }
    
    var emojiStr: String?
    
    var id: String?
    
    var imagePath: String?
    
    var isRemoveButton: Bool = false
    
    var times: Int = 0
    
    init(isRemoveButton: Bool)
    {
        super.init()
        self.isRemoveButton = isRemoveButton
    }
    
    init(dict: [String: String], id: String)
    {
        super.init()
        self.id = id
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
