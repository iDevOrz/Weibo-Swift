//
//  UITextView+Category.swift
//  表情键盘界面布局
//
//  Created by 张建宇 on 16/3/3.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit


extension UITextView
{
    func insertEmoticon(emoticon: Emoticon)
    {
        if emoticon.isRemoveButton
        {
            deleteBackward()
        }

        if emoticon.emojiStr != nil{
            self.replaceRange(self.selectedTextRange!, withText: emoticon.emojiStr!)
        }
        
        if emoticon.png != nil{
            
            let imageText = EmoticonTextAttachment.imageText(emoticon, font: font ?? UIFont.systemFontOfSize(17))
            
            
            let strM = NSMutableAttributedString(attributedString: self.attributedText)
            
            let range = self.selectedRange
            strM.replaceCharactersInRange(range, withAttributedString: imageText)
            
            strM.addAttribute(NSFontAttributeName, value: font! , range: NSMakeRange(range.location, 1))
            
            self.attributedText = strM
            self.selectedRange = NSMakeRange(range.location + 1, 0)
            
            delegate?.textViewDidChange!(self)
        }
    }
    
    func emoticonAttributedText() -> String
    {
        var strM = String()
        attributedText.enumerateAttributesInRange( NSMakeRange(0, attributedText.length), options: NSAttributedStringEnumerationOptions(rawValue: 0)) { (objc, range, _) -> Void in
            
            if objc["NSAttachment"] != nil
            {
                let attachment =  objc["NSAttachment"] as! EmoticonTextAttachment
                strM += attachment.chs!
            }else
            {
                strM += (self.text as NSString).substringWithRange(range)
            }
        }
        return strM
    }
}