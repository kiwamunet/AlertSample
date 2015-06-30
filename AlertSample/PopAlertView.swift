//
//  PopView.swift
//  VegasApp
//
//  Created by tanaka_yu_gn on 2015/04/02.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//

import Foundation

enum AlertContentType {
    case Contents(str: String)
    case Selection(select: (yes: String, no: String), str: String, completion: (Bool) -> ())
    case SelectionReport(select: (yes: String, no: String), str: String, image: UIImage, name: String, reportMsg: String, completion: (Bool) -> ())
    case Agreement(title: String, str: String, completion: () -> ())
    case Update(title: String, str: String, completion: () -> ())
    case Toast()
}






enum AlertSize: Int {
    case Small = 1, Middle, Large, CustomSize
    func getSize(percent: CGFloat?) -> CGRect {
        switch self {
        case .Small:
            let flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, 120)
            return flame
        case .Middle:
            let flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, 160)
            return flame
        case .Large:
            let flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, 240)
            return flame
        case .CustomSize:
            if percent != nil {
                let flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, UIScreen.mainScreen().bounds.height * percent!)
                return flame
            } else {
                let flame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, UIScreen.mainScreen().bounds.height * 0.5)
                return flame
            }
        }
    }
}





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
    
    
    func setView(windowView: CGRect? = nil, inner: CGRect? = nil , size: AlertSize? = nil, isCenter: Bool? = nil) {
        
        if windowView == nil {
            if UIApplication.isPortrait {
                self.win = UIWindow(frame: UIScreen.mainScreen().bounds)
            } else {
                self.win = UIWindow(frame: CGRectMake(0,0, UIScreen.mainScreen().bounds.height, UIScreen.mainScreen().bounds.width))
            }
        } else {
            self.win = UIWindow(frame: windowView!)
        }
        
        
        if inner == nil {
            if UIApplication.isPortrait {
                if size != nil {
                    switch size! {
                    // サイズの振り分け
                    case AlertSize.Small:
                        self.frame = AlertSize.Small.getSize(nil)
                    case AlertSize.Middle:
                        self.frame = AlertSize.Middle.getSize(nil)
                    case AlertSize.Large:
                        self.frame = AlertSize.Large.getSize(nil)
                    case AlertSize.CustomSize:
                        self.frame = AlertSize.CustomSize.getSize(10.0)
                    default:
                        break
                    }
                } else {
                    self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, UIScreen.mainScreen().bounds.height/3)
                }
            } else {
                self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width-40, UIScreen.mainScreen().bounds.height * 3/5)
            }
            self.center = CGPointMake(CGRectGetMidX(self.win!.bounds), CGRectGetMidY(self.win!.bounds))
        } else {
            self.frame = inner!
        }
        
        if isCenter != nil {
            self.center = CGPointMake(CGRectGetMidX(self.win!.bounds), CGRectGetMidY(self.win!.bounds))
        }
        
        self.win!.windowLevel = UIWindowLevelAlert
        self.win!.backgroundColor = UIColor.clearColor()
        
        let bgView = UIView(frame: CGRectMake(0, 0, self.win!.width, self.win!.height))
        
        
        bgView.backgroundColor = UIColor.blackColor()
        bgView.alpha = 0.5
        self.win!.addSubview(bgView)
        
        self.innerView = PopAlertInnerView(frame: CGRectMake(0, 0, self.size.width, self.size.height))
        self.innerView!.delegate = self
        
        self.addSubview(self.innerView!)
        self.backgroundColor = UIColor.clearColor()
        if UIApplication.isLandscape {
            self.rotate(self)
        }
    }
    
    func show(type: AlertContentType) {
        self.showAnimated(true, type: type)
    }
    
    func showToast(type: AlertContentType) {
        self.showAnimated(true, type: type)
        self.toasTimer()
    }
    
    private func toasTimer () {
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "countTime:", userInfo: nil, repeats: true)
    }
    
    func countTime (time: NSTimer) {
        countNum++
        if countNum >= 2 {
            self.hide()
            countNum = 0
            timer.invalidate()
        }
    }
    
    private func showAnimated(animated: Bool, type: AlertContentType) {
        
        self.innerView!.setTypeLayout(type, block: { [weak self] in
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