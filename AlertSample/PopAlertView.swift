//
//  PopView.swift
//  VegasApp
//
//  Created by tanaka_yu_gn on 2015/04/02.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//

import Foundation
import UIKit


enum AlertType: Int {
    case Contents = 0, Selection, UserBan, AutoHide
}







//enum AlertSize: Int {
//    case Small = 1, Middle, Large, Custom
//    func getSize() -> CGRect {
//        var flame = CGRectZero
//        switch self {
//        case .Small:
//            if UIApplication.isPortrait {
//                flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width * 0.9, UIScreen.mainScreen().bounds.width * 0.5)
//            } else {
//                flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, 120)
//            }
//            return flame
//        case .Middle:
//            if UIApplication.isPortrait {
//                flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width * 0.9, UIScreen.mainScreen().bounds.height * 0.6)
//            } else {
//                flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, 160)
//            }
//            return flame
//        case .Large:
//            if UIApplication.isPortrait {
//                flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, 240)
//            } else {
//                flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, 240)
//            }
//            return flame
//        case .Custom:
//            break
//        }
//    }
//}









class PopAlertView: UIView, PopAlertInnerViewDelegate {
    
    var win: UIWindow? = nil
    var innerView: PopAlertInnerView? = nil
    var countNum = 0
    var timer : NSTimer!

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log("PopAlertView init!")
    }
    
    override init(frame: CGRect? = nil) {
        super.init(frame: CGRectMake(0, 0, 0, 0))
        Log("PopAlertView init!")
    }
    
    
    func setView(windowView: CGRect? = nil, inner: CGRect? = nil, isCenter: Bool = false, contents: [String: Any?]) {
        
        
        
        if windowView == nil {
            if UIApplication.isPortrait {
                self.win = UIWindow(frame: UIScreen.mainScreen().bounds)
            } else {
                self.win = UIWindow(frame: CGRectMake(0,0, UIScreen.mainScreen().bounds.height, UIScreen.mainScreen().bounds.width))
            }
        } else {
            self.win = UIWindow(frame: windowView!)
        }
        
        self.frame = (self.win?.frame)!
        self.win!.windowLevel = UIWindowLevelAlert
        self.win!.backgroundColor = UIColor.clearColor()
        
        let bgView = UIView(frame: CGRectMake(0, 0, self.win!.width, self.win!.height))
        
        
        bgView.backgroundColor = UIColor.blackColor()
        bgView.alpha = 0.5
        self.win!.addSubview(bgView)
        
        
        
        let resizeHeight = min(PopAlertInnerView.sizeForView(text: (contents[PopAlertViewContentTitleKey] as? String) ?? nil, viewWidth: self.size.width, type: (contents[PopAlertViewTypeKey] as? AlertType)!), UIScreen.mainScreen().bounds.height * 0.6)
        self.innerView = PopAlertInnerView(frame: CGRectMake(0, 0, self.frame.size.width-40, resizeHeight))
        self.innerView!.delegate = self
       
        //センターがtrueの場合はセンターに合わせる
        if isCenter {
            self.innerView!.center = CGPointMake(CGRectGetMidX(self.win!.bounds), CGRectGetMidY(self.win!.bounds))
        }
        
        
        
        self.addSubview(self.innerView!)
        self.backgroundColor = UIColor.clearColor()
        if UIApplication.isLandscape {
            self.rotate(self)
        }
    }
    

    
    
    
    
    
    
    
    func show(contents: [String: Any?]) {
        
        if let alertType = contents[PopAlertViewTypeKey] as? AlertType {
            if alertType == AlertType.AutoHide {
                self.toasTimer(2.0)
            }
        }
        self.showAnimated(true, contents: contents)
    
    }
    
    
    private func showAnimated(animated: Bool, contents:[String: Any?]) {
        self.innerView!.setTypeLayout(contents, block: { [weak self] in
            self?.win!.addSubview(self!)
            self?.win!.makeKeyAndVisible()
            
            if animated {
                if let win = self?.win as UIWindow! {
                    win.transform = CGAffineTransformMakeScale(1.5, 1.5)
                    win.alpha = 0.0
                    
                    AnimationChain.animate(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, springOptions: (0.8,1), animation: { [weak win] in
                        win?.transform = CGAffineTransformMakeScale(1, 1)
                        win?.alpha = 1
                        }).start()
                }
            }
        })
    }
    
    
    
    
    
    
    
    
    
    
    
    private func toasTimer(interval: NSTimeInterval) {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
        timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: "countTime:", userInfo: nil, repeats: true)
    }
    
    func countTime (time: NSTimer) {
        self.hide()
        timer.invalidate()
        timer = nil
    }
    
    
    
    
    
    
    func hide() {
        self.hideAnimated(true)
        PopAlertViewService.sharedInstance.next()
    }
    
    
    
    func hideWithCompletion(completion: () -> ()) {
        self.hideAnimated(true, completion: completion)
    }
    
    
    
    
    private func hideAnimated(animated: Bool, completion: () -> () = {}) {
        if animated {
            if let win = self.win as UIWindow! {
                AnimationChain.animate(0.1, delay: 0, animation: { [weak win, weak self] in
                    win?.transform = CGAffineTransformMakeScale(1.2, 1.2)
                    win?.alpha = 0
                    }).completion({ [weak win, weak self] in
                        win?.hidden = true
                        self?.win = nil
                        completion()
                        }).start()
            }
        } else {
            if let win = self.win as UIWindow! {
                win.hidden = true
            }
            self.win = nil
            completion()
        }
    }
    
    // MARK: innerViewDelegate
    func popAlertInnerViewCloseTapped() {
        self.hide()
    }
    
    func rotate(view: UIView) {
        var rotation: CGFloat = 0.0
        switch UIApplication.sharedApplication().statusBarOrientation {
        case UIInterfaceOrientation.Portrait:
            rotation = 0.0
            break
        case .PortraitUpsideDown:
            rotation = CGFloat(M_PI)
            break
        case .LandscapeLeft:
            rotation = -CGFloat(M_PI_2)
            break
        case .LandscapeRight:
            rotation = CGFloat(M_PI_2)
            break
        default:
            break
        }
        view.transform = CGAffineTransformMakeRotation(rotation)
    }
    
    deinit {
        Log("PopAlertView deinit!")
    }
    
}