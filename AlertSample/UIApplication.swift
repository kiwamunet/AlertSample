//
//  UIApplicationExtension.swift
//  VegasApp
//
//  Created by A12893 on 2014/12/13.
//  Copyright (c) 2014年 Ameba Studio. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    class var isLandscape: Bool { return sharedApplication().statusBarOrientation.isLandscape }
    class var isPortrait: Bool { return sharedApplication().statusBarOrientation.isPortrait }
}