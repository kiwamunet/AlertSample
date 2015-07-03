//
//  ReportManager.swift
//  VegasApp
//
//  Created by 田中　佑 on 2015/05/29.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//

import Foundation

class ReportManager: NSObject {
    
    class func postReport(channelId: String, userId: String, nickname: String, msg: String, msgId: String, completion: (Bool) -> ()) {
        
        let param = ["postUserId": "おれ",
                     "channelId": channelId,
                     "userId": userId,
                     "nickname": nickname,
                     "message": msg,
                     "messageId": msgId
        ]
        
//        NetworkManager.sharedInstance.requestActivePostApi(API_URL_REPORT, parameters: param, success: { response in
//            if response != nil {
                completion(true)
//            } else {
//                completion(false)
//            }
//        }, failure: { (task, error) in
//            completion(false)
//        })
        
    }
}