//
//  UIScreen.swift
//  VegasApp
//
//  Created by 田中　佑 on 2015/06/12.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//

import UIKit

extension UIScreen {
    
    class var commonSize: CGSize {
        var screenSize = UIScreen.mainScreen().bounds.size
        if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) &&  UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)) {
            screenSize = CGSizeMake(screenSize.height, screenSize.width);
        }
        return screenSize
    }
    
    class var commonWidth: CGFloat {
        return commonSize.width
    }
    
    class var commonHeight: CGFloat {
        return commonSize.height
    }
    
}