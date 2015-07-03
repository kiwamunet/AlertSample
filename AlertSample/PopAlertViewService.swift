//
//  PopAlertViewService.swift
//  VegasApp
//
//  Created by 田中　佑 on 2015/06/11.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//

import Foundation
import UIKit





let PopAlertViewWindowKey = "window"
let PopAlertViewInnerKey = "inner"
let PopAlertViewCenterKey = "center"
let PopAlertViewNetworkKey = "network"
let PopAlertViewSizeKey = "size"
let PopAlertViewAltKey = "altKey"
let PopAlertViewTypeKey = "type"
let PopAlertViewContentTitleKey = "contentTitle"
let PopAlertViewContentButtonTitleKey = "contentButtonTitle"
let PopAlertViewContentButtonYesKey = "contentButtonYes"
let PopAlertViewContentButtonNoKey = "contentButtonNo"
let PopAlertViewImageKey = "image"
let PopAlertViewUserNameKey = "userName"
let PopAlertViewUserChatMessageKey = "userChatMessage"
let PopAlertViewCompleteSelectedKey = "completeSelected"









class PopAlertViewService: NSObject {
    
    var alert: PopAlertView?
    var waitingView = [[String: AnyObject?]]()
    var waitingContents = [[String: Any?]]()
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
    
    
    
    
    
    
    
    
    func checkCurrentKey(altKey: String?) -> Bool {
        if self.currentKey != nil {
            if self.currentKey == altKey {
                return false
            } else {
                for viewSet in self.waitingView {
                    if viewSet[PopAlertViewAltKey] as? String == altKey {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    
    
    
    
    //-------------------------------
    //contents
    //-------------------------------
    func setContentAlert(windowView: CGRect? = nil, inner: CGRect? = nil, contentTitle: String, contentButtonTitle: String, isCenter: Bool? = nil, isNetwork: Bool = false, altKey: String?, complete:(selected: Bool) -> Void) {
   
        //現在同じアラートが出ている場合は出さない
        if !self.checkCurrentKey(altKey) {
            return
        }
        
        //ネットワークのチェックが必要な場合はチェックする
        if isNetwork {
            self.checkNetwork({() in
                // キューにセット
                self.waitingView.append([PopAlertViewWindowKey: windowView as? AnyObject, PopAlertViewInnerKey: inner as? AnyObject, PopAlertViewCenterKey: isCenter as? AnyObject, PopAlertViewNetworkKey: isNetwork, PopAlertViewAltKey: altKey as? AnyObject])
                self.waitingContents.append([PopAlertViewTypeKey: AlertType.Contents, PopAlertViewContentTitleKey: contentTitle, PopAlertViewContentButtonTitleKey : contentButtonTitle, PopAlertViewCompleteSelectedKey: complete])
                //実行
                self.RunInTheOrder()
            })
        } else {
            // キューにセット
            self.waitingView.append([PopAlertViewWindowKey: windowView as? AnyObject, PopAlertViewInnerKey: inner as? AnyObject, PopAlertViewCenterKey: isCenter as? AnyObject, PopAlertViewNetworkKey: isNetwork, PopAlertViewAltKey: altKey as? AnyObject])
            self.waitingContents.append([PopAlertViewTypeKey: AlertType.Contents, PopAlertViewContentTitleKey: contentTitle, PopAlertViewContentButtonTitleKey : contentButtonTitle, PopAlertViewCompleteSelectedKey: complete])
            //実行
            self.RunInTheOrder()
        }
       
        
    }
    
    
    
    
    
    
    
    
    //-------------------------------
    //Selection
    //-------------------------------
    func setSelectionAlert(windowView: CGRect? = nil, inner: CGRect? = nil, contentTitle: String, contentButtonYes: String = "はい", contentButtonNo: String = "いいえ", isCenter: Bool? = nil, isNetwork: Bool = false, altKey: String?, complete:(selected: Bool) -> Void) {
        
        //現在同じアラートが出ている場合は出さない
        if !self.checkCurrentKey(altKey) {
            return
        }
        //ネットワークのチェックが必要な場合はチェックする
        if isNetwork {
            self.checkNetwork({() in
                // キューにセット
                self.waitingView.append([PopAlertViewWindowKey: windowView as? AnyObject, PopAlertViewInnerKey: inner as? AnyObject, PopAlertViewCenterKey: isCenter as? AnyObject, PopAlertViewNetworkKey: isNetwork, PopAlertViewAltKey: altKey as? AnyObject])
                self.waitingContents.append([PopAlertViewTypeKey: AlertType.Selection, PopAlertViewContentTitleKey: contentTitle, PopAlertViewContentButtonYesKey: contentButtonYes, PopAlertViewContentButtonNoKey: contentButtonNo, PopAlertViewCompleteSelectedKey: complete])
                //実行
                self.RunInTheOrder()
            })
        } else {
            // キューにセット
            self.waitingView.append([PopAlertViewWindowKey: windowView as? AnyObject, PopAlertViewInnerKey: inner as? AnyObject, PopAlertViewCenterKey: isCenter as? AnyObject, PopAlertViewNetworkKey: isNetwork, PopAlertViewAltKey: altKey as? AnyObject])
            self.waitingContents.append([PopAlertViewTypeKey: AlertType.Selection, PopAlertViewContentTitleKey: contentTitle, PopAlertViewContentButtonYesKey: contentButtonYes, PopAlertViewContentButtonNoKey: contentButtonNo, PopAlertViewCompleteSelectedKey: complete])
            //実行
            self.RunInTheOrder()
        }
    }

    
    
    //-------------------------------
    // UserBan
    //-------------------------------
    func setUserBanAlert(windowView: CGRect? = nil, inner: CGRect? = nil, contentTitle: String, contentButtonYes: String = "はい", contentButtonNo: String = "いいえ", image: UIImage, userName:String, userChatMessage: String, isCenter: Bool? = nil, isNetwork: Bool = false, altKey: String?, complete:(selected: Bool) -> Void) {
        
        //現在同じアラートが出ている場合は出さない
        if !self.checkCurrentKey(altKey) {
            return
        }
        
        //ネットワークのチェックが必要な場合はチェックする
        if isNetwork {
            self.checkNetwork({() in
                // キューにセット
                self.waitingView.append([PopAlertViewWindowKey: windowView as? AnyObject, PopAlertViewInnerKey: inner as? AnyObject, PopAlertViewCenterKey: isCenter as? AnyObject, PopAlertViewNetworkKey: isNetwork, PopAlertViewAltKey: altKey as? AnyObject])
                self.waitingContents.append([PopAlertViewTypeKey: AlertType.UserBan, PopAlertViewContentTitleKey: contentTitle, PopAlertViewContentButtonYesKey: contentButtonYes, PopAlertViewContentButtonNoKey: contentButtonNo, PopAlertViewImageKey: image, PopAlertViewUserNameKey: userName, PopAlertViewUserChatMessageKey: userChatMessage, PopAlertViewCompleteSelectedKey: complete])
                //実行
                self.RunInTheOrder()
            })
        } else {
            // キューにセット
            self.waitingView.append([PopAlertViewWindowKey: windowView as? AnyObject, PopAlertViewInnerKey: inner as? AnyObject, PopAlertViewCenterKey: isCenter as? AnyObject, PopAlertViewNetworkKey: isNetwork, PopAlertViewAltKey: altKey as? AnyObject])
            self.waitingContents.append([PopAlertViewTypeKey: AlertType.UserBan, PopAlertViewContentTitleKey: contentTitle, PopAlertViewContentButtonYesKey: contentButtonYes, PopAlertViewContentButtonNoKey: contentButtonNo, PopAlertViewImageKey: image, PopAlertViewUserNameKey: userName, PopAlertViewUserChatMessageKey: userChatMessage, PopAlertViewCompleteSelectedKey: complete])
            //実行
            self.RunInTheOrder()
        }
    }

    
    
    
    //-------------------------------
    // AutoHide
    //-------------------------------
    func setAutoHideAlert(windowView: CGRect? = nil, inner: CGRect? = nil, altKey: String?) {
        
        //現在同じアラートが出ている場合は出さない
        if !self.checkCurrentKey(altKey) {
            return
        }
        
        
        // キューにセット
        self.waitingView.append([PopAlertViewWindowKey: windowView as? AnyObject, PopAlertViewInnerKey: inner as? AnyObject, PopAlertViewCenterKey: true, PopAlertViewAltKey: altKey as? AnyObject])
        self.waitingContents.append([PopAlertViewTypeKey: AlertType.AutoHide])
        
        
        //実行
        self.RunInTheOrder()
    }
    
    
    
    
    
    
    /**
    アラートキューを実行する
    */
    func RunInTheOrder() {
        if self.waitingView.count > 0 && self.waitingContents.count > 0 {
            
            self.alert = PopAlertView(frame: nil)
            
            self.alert!.setView(windowView: self.waitingView[0][PopAlertViewWindowKey] as! CGRect?,
                inner: self.waitingView[0][PopAlertViewInnerKey] as! CGRect?,
                isCenter: self.waitingView[0][PopAlertViewCenterKey] as! Bool? ?? false, contents: self.waitingContents[0])
            
            self.alert!.show(self.waitingContents[0])
            
            self.currentKey = self.waitingView[0][PopAlertViewWindowKey] as? String
            self.waitingView.removeAtIndex(0)
            self.waitingContents.removeAtIndex(0)
        }
    }
    
    
    
    
    
    
    func checkNetwork(completion:() -> Void) {
        if !Reachability.isConnectedToNetwork() {
            // TODO: ネットワーク不通の場合は、どのような対応をとるか、そのあとのアラートを削除すべきか
            PopAlertViewService.sharedInstance.setContentAlert(windowView: nil, inner: nil, contentTitle: "ネットワークが不安定です\n電波の良いところで\n再度お試しください", contentButtonTitle: "リトライ", isCenter: true, isNetwork: false, altKey: "NETWORKRETRY", complete: { [weak self] (selected: Bool) in
                self!.checkNetwork({() in
                   completion()
                })
            })
        } else {
            //コンプレッション
            completion()
        }
    }




    func next(retry: Bool = false) {
        if !nextFlg {
            removeAll()
            return
        }
        
        self.alert = nil
        self.currentKey = nil
        if self.waitingView.count > 0 && self.waitingContents.count > 0 {
            //ネットワークのチェックが必要な場合はチェックする
            if self.waitingView[0][PopAlertViewNetworkKey] as! Bool {
                self.checkNetwork({() in
                    self.RunInTheOrder()
                })
            } else {
                //実行
                self.RunInTheOrder()
            }
        }
    }
    
    
    
    
    func removeAll() {
        self.alert = nil
        self.currentKey = nil
        self.waitingView.removeAll(keepCapacity: false)
        self.waitingView = []
        self.waitingContents = []
        self.nextFlg = true
    }
    
    
    
    
    
    func hideAndRemoveAll() {
        self.alert?.hideWithCompletion({})
        self.removeAll()
    }
    
}