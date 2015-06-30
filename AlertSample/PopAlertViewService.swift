//
//  PopAlertViewService.swift
//  VegasApp
//
//  Created by 田中　佑 on 2015/06/11.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//

import Foundation

class PopAlertViewService: NSObject {
    
    var alert: PopAlertView?
    var waitingView = [[String: AnyObject?]]()
    var waitingTypes = [AlertContentType]()
    var currentKey: String?
    var nextFlg: Bool = true
    
    class var sharedInstance : PopAlertViewService {
        struct Singleton {
            static var instance = PopAlertViewService()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
    }
    
    func setView(windowView: CGRect? = nil, inner: CGRect? = nil, isCenter: Bool? = nil, isToast: Bool? = nil, type: AlertContentType, size :AlertSize? = nil, altKey: String?) {
        
        if self.currentKey != nil {
            if self.currentKey == altKey {
                return
            } else {
                for viewSet in self.waitingView {
                    if viewSet["key"] as? String == altKey {
                        return
                    }
                }
            }
        }
        
        if !Reachability.isConnectedToNetwork() && self.alert == nil {
            self.checkNetwork()
        }
        
        if self.alert != nil {
            self.waitingView.append(["window": windowView as? AnyObject, "inner": inner as? AnyObject, "center": isCenter as? AnyObject, "toast": isToast,"size": size as? AnyObject, "key": altKey as? AnyObject])
            self.waitingTypes.append(type)
            return
        }
        
        self.alert = PopAlertView(frame: nil)
        self.alert!.setView(windowView: windowView, inner: inner, isCenter: isCenter, size: size)
        
        
        if isToast != nil && isToast! {
            self.alert!.showToast(type)
        } else {
            self.alert!.show(type)
        }
        self.currentKey = altKey
        
    }
    
    func checkNetwork() {
        let type = AlertContentType.Agreement(title: "リトライ", str: "ネットワークが不安定です\n電波の良いところで\n再度お試しください", completion: {
            if !Reachability.isConnectedToNetwork() {
                return
            }
        })
        self.alert = PopAlertView(frame: nil)
        self.alert!.setView(windowView: nil, inner: nil, isCenter: nil)
        self.alert!.show(type)
    }
    
    func next(retry: Bool = false) {
        if !nextFlg {
            removeAll()
            return
        }
        
        self.alert = nil
        self.currentKey = nil
        
        if !Reachability.isConnectedToNetwork() {
            self.checkNetwork()
            return
        }
        
        if self.waitingView.count > 0 && self.waitingTypes.count > 0 {
            self.alert = PopAlertView(frame: nil)
            self.alert!.setView(windowView: self.waitingView[0]["window"] as! CGRect?, inner: self.waitingView[0]["inner"] as! CGRect?, isCenter: self.waitingView[0]["center"] as! Bool?)
            if self.waitingView[0]["toast"] as? Bool != nil && self.waitingView[0]["toast"] as! Bool {
                self.alert!.showToast(self.waitingTypes[0])
            } else {
                self.alert!.show(self.waitingTypes[0])
            }
            self.currentKey = self.waitingView[0]["key"] as? String
            self.waitingView.removeAtIndex(0)
            self.waitingTypes.removeAtIndex(0)
        }
    }
    
    func removeAll() {
        self.alert = nil
        self.currentKey = nil
        self.waitingView.removeAll(keepCapacity: false)
        self.waitingView = []
        self.waitingTypes = []
        self.nextFlg = true
    }
    
    func hideAndRemoveAll() {
        self.alert?.hideWithCompletion({})
        self.removeAll()
    }
    
}