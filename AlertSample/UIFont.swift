//
//  UIFont.swift
//  VegasApp
//
//  Created by suzuki_kiwamu on 2015/03/31.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//


import Foundation
import UIKit

extension UIFont {
    
    class func hiraginokakugoW3(fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "ヒラギノ角ゴ ProN W6", size: fontSize) {
            return font
        }
        return systemFontOfSize(fontSize)
    }
    
    class func hiraginokakugoW6(fontSize: CGFloat) -> UIFont {
        if let font = UIFont(name: "ヒラギノ角ゴ ProN W6", size: fontSize) {
            return font
        }
        return systemFontOfSize(fontSize)
    }

}