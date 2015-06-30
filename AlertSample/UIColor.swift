//
//  CGColorExtension.swift
//  VegasApp
//
//  Created by A12893 on 2014/11/30.
//  Copyright (c) 2014年 Ameba Studio. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    // #0bdbc6(R:11, G:219, B:198)
    class func baseColor() -> UIColor {
        return UIColor(red: 0.04, green: 0.86, blue: 0.78, alpha: 1)
    }
    
    // #0bdbc6(R:11, G:219, B:198 alpha: 32%)
    class func lightBaseColor() -> UIColor {
        return UIColor(red: 0.04, green: 0.86, blue: 0.78, alpha: 0.32)
    }
    // #1d1d1d(R:29, G:29, B:29)
    class func headerColor() -> UIColor {
        return UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
    }
 
    // #353535(R:53, G:53, B:53) 灰色
    class func editableColor() -> UIColor {
        return UIColor(red: 0.21, green: 0.21, blue: 0.21, alpha: 1)
    }
    
    // #b5b5b5(R:181, G:181, B:181) 白
    class func customLightWhiteColor() -> UIColor {
        return UIColor(red: 0.71, green: 0.71, blue: 0.71, alpha: 1)
    }
    
    // #ececec(R:236, G:236, B:236) 白
    class func customWhiteFontColor() -> UIColor {
        return UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1)
    }
    
    // #666666(R:102, G:102, B:102) 灰色
    class func customGrayFontColor() -> UIColor {
        return UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1)
    }
    
    // #969696(R:150, G:150, B:150) 少し明るい灰色
    class func customLiteGrayFontColor() -> UIColor {
        return UIColor(red: 0.60, green: 0.60, blue: 0.60, alpha: 1)
    }
    
    // #00FFFF(R:0, G:255, B:255)　水色
    class func lightBuleAllowColor() -> UIColor {
        return UIColor(red: 0, green: 1.0, blue: 1.0, alpha: 1)
    }
    
    // #0ac9b6(R:0, G:172, B:155)　水色 //imagepickerNavigationColor
    class func imagepickerNavigationColor() -> UIColor {
        return UIColor(red: 0, green: 0.67, blue: 0.61, alpha: 1)
    }
    
    
    
    class func alphaColor(alpha: CGFloat) -> UIColor {
        return UIColor.blackColor().colorWithAlphaComponent(alpha)
    }
    
    class func colorWith(#hex: String) -> UIColor? {
        return nil
    }
}

