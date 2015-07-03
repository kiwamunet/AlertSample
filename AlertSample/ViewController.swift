//
//  ViewController.swift
//  AlertSample
//
//  Created by suzuki_kiwamu on 2015/06/29.
//  Copyright (c) 2015年 suzuki_kiwamu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var selectedResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    
    
    @IBAction func Contents(sender: AnyObject) {
        PopAlertViewService.sharedInstance.setContentAlert(windowView: nil, inner: nil, contentTitle: "Swift の enum は AnyObject 型変数に代入できないSwift の enum は AnyObject 型変数に代入できないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できない", contentButtonTitle: "bbbb", isCenter: true, isNetwork: true, altKey: "aaaa", complete: {(selected: Bool) in
            println("result == \(selected)")
            self.selectedResult.text = "true"
        })
        
    }
    
    
    
    
    
    @IBAction func Selection(sender: AnyObject) {
        PopAlertViewService.sharedInstance.setSelectionAlert(windowView: nil, inner: nil, contentTitle: "Swift の enum は AnyObject 型変数に代入できないSwift の enum は AnyObject 型変数に代入できないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できないないSwift の enum は AnyObject 型変数に代入できない", contentButtonYes: "ほい", contentButtonNo: "ノー", isCenter: true, isNetwork: true, altKey: "ssssss", complete: {(selected: Bool) in
            
            if selected {
                println("result == \(selected)")
                self.selectedResult.text = "true"
            } else {
                println("result == \(selected)")
                self.selectedResult.text = "false"
            }
        })
    }
    
    
    
    
    
    
    
    @IBAction func SelectionReport(sender: AnyObject) {
        PopAlertViewService.sharedInstance.setUserBanAlert(windowView: nil, inner: nil, contentTitle: "コンテンツタイトル", contentButtonYes: "はい", contentButtonNo: "いいえ", image: UIImage(named: "sampleImage")!, userName: "ユーザの名前", userChatMessage: "チャットメッセージだよだよ(〃´Д`)ｱｱ…(*´Д`*) 〜з(ﾉ_-;)ｱｧ…(´д｀;)ｱｧ…(´ﾟдﾟ｀)ｱｱ…", isCenter: true, isNetwork: true, altKey: "hogheogheo", complete: {(selected: Bool) in
            
            if selected {
                println("result == \(selected)")
                self.selectedResult.text = "true"
            } else {
                println("result == \(selected)")
                self.selectedResult.text = "false"
            }
        })
    }
    
    
    
    
    
    
    @IBAction func Toast(sender: AnyObject) {
        PopAlertViewService.sharedInstance.setAutoHideAlert(windowView: nil, inner: nil, altKey: "aaa")
    
    }
    
    
    
}

