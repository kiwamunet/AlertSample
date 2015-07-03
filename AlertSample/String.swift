//
//  AnyClassExtension.swift
//  VegasApp
//
//  Created by A12893 on 2014/11/22.
//  Copyright (c) 2014年 Ameba Studio. All rights reserved.
//

import Foundation
import UIKit

extension String {
    init(_ clazz: AnyClass, shortName: Bool = true) {
        let longName = NSStringFromClass(clazz)
        if shortName {
            self = longName.componentsSeparatedByString(".").last!
        } else {
            self = longName
        }
    }
    
    var length: Int { return count(self)         }  // Swift 1.2
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(.whitespaceAndNewlineCharacterSet())
    }
    
    func split(sep: String) -> [String] {
        return self.componentsSeparatedByString(sep).map { $0.trim() }
    }
    
    func isBlank() -> Bool {
        if count(self.trim().utf16) > 0 {
        	return true
        } else {
            return false
        }
    }
    
    
    /**
    任意の位置に文字列挿入
    :param: string 挿入する文字列
    :param: index  挿入する位置
    */
    mutating func insert(#string:String, atIndex:Int) {
        self = prefix(self,atIndex) + string + suffix(self,count(self)-atIndex)
    }

    
    
    func sizeWithFont(font:UIFont, lineBreakMode:NSLineBreakMode, constrainedToSize size:CGSize, lineSpacing: CGFloat=0) -> CGSize {
        var style = NSMutableParagraphStyle()
        style.lineBreakMode = lineBreakMode
        style.lineSpacing = lineSpacing
        var titleAttr = [
            NSFontAttributeName: font,
            NSParagraphStyleAttributeName: style
        ]
        var rect = (self as NSString).boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: titleAttr, context: NSStringDrawingContext())
        return rect.size
    }
}
