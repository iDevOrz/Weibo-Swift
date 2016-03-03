//
//  EmoticonTextAttachment.swift
//  表情键盘界面布局
//
//  Created by 张建宇 on 16/3/3.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class EmoticonTextAttachment: NSTextAttachment {
    var chs: String?
    
    class func imageText(emoticon: Emoticon, font: UIFont) -> NSAttributedString{
        
        let attachment = EmoticonTextAttachment()
        attachment.chs = emoticon.chs
        attachment.image = UIImage(contentsOfFile: emoticon.imagePath!)
        let s = font.lineHeight
        attachment.bounds = CGRectMake(0, -4, s, s)
        
        return NSAttributedString(attachment: attachment)
    }
}
