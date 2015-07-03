//
//  PopAlertInnerView.swift
//  VegasApp
//
//  Created by tanaka_yu_gn on 2015/04/02.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//

import Foundation
import UIKit

protocol PopAlertInnerViewDelegate: class {
    func popAlertInnerViewCloseTapped()
}

class PopAlertInnerView: UIView {

    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentButton: UIButton!
    
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var selectionYesButton: UIButton!
    @IBOutlet weak var selectionNoButton: UIButton!
    
    

    @IBOutlet weak var userBanView: UIView!
    @IBOutlet weak var userBanImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userBanLabel: UILabel!
    @IBOutlet weak var userBanChatMessageLabel: UILabel!
    @IBOutlet weak var userBanYesButton: UIButton!
    @IBOutlet weak var userBanNoButton: UIButton!
   
    
    
    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var authMark: UILabel!
    
    
    weak var delegate: PopAlertInnerViewDelegate?
    private var mainView:UIView? = nil
   
    private var closeRejection = false
    var selectionCompletion: ((Bool) -> ())? = nil
    var selectionReportCompletion: ((Bool) -> ())? = nil
    var agreementCompletion: (() -> ())? = nil
    
    
    
    
    var completeSelected: (selected: Bool) -> Void = {(selected: Bool) in}
  
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log("PopAlertInnerView init!")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.mainView = NSBundle.mainBundle().loadNibNamed("PopAlertInnerView", owner: self, options: nil).first as? UIView
        self.mainView?.frame = frame
        self.mainView?.setNeedsLayout()
        self.mainView?.layoutIfNeeded()
        addSubview(self.mainView!)
        Log("PopAlertInnerView init!")
    }
    
    
    
   
    func createAttributedText(str: String) -> NSMutableAttributedString {
        let attributedText = NSMutableAttributedString(string: str)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    
    
    func setTypeLayout(contents: [String: Any?], block: () -> ()) {
        
        switch contents[PopAlertViewTypeKey] as! AlertType {
        case .Contents:
            
            self.contentView.hidden = false
            self.contentLabel.attributedText = createAttributedText((contents[PopAlertViewContentTitleKey] as? String)!)
            self.contentButton.setTitle(contents[PopAlertViewContentButtonTitleKey] as? String, forState: UIControlState.Normal)
            self.completeSelected = (contents[PopAlertViewCompleteSelectedKey] as? (selected: Bool) -> Void)!
            block()
            break
        
        case .Selection:
            self.selectionView.hidden = false
            self.selectionLabel.attributedText = createAttributedText((contents[PopAlertViewContentTitleKey] as? String)!)
            self.selectionYesButton.setTitle(contents[PopAlertViewContentButtonYesKey] as? String, forState: UIControlState.Normal)
            self.selectionNoButton.setTitle(contents[PopAlertViewContentButtonNoKey] as? String, forState: UIControlState.Normal)
            self.completeSelected = (contents[PopAlertViewCompleteSelectedKey] as? (selected: Bool) -> Void)!
            block()
            break
        
        case .UserBan:
            self.userBanView.hidden = false
            self.userBanLabel.text = contents[PopAlertViewContentTitleKey] as? String
            self.userBanImageView.image = contents[PopAlertViewImageKey] as? UIImage
            self.userName.text = contents[PopAlertViewUserNameKey] as? String
            self.userBanChatMessageLabel.text = contents[PopAlertViewUserChatMessageKey] as? String
            self.userBanYesButton.setTitle(contents[PopAlertViewContentButtonYesKey] as? String, forState: UIControlState.Normal)
            self.userBanNoButton.setTitle(contents[PopAlertViewContentButtonNoKey] as? String, forState: UIControlState.Normal)
            self.completeSelected = (contents[PopAlertViewCompleteSelectedKey] as? (selected: Bool) -> Void)!
            block()
            break
        case .AutoHide:
            self.toastView.hidden = false
            self.authMark.text = icomoon.e602
            self.authMark.adjustsFontSizeToFitWidth = true
            self.authMark.layer.cornerRadius = self.authMark.size.width * 0.5
            self.authMark.clipsToBounds = true
            block()
            break
        }
    }

    
    
    
    
    class func sizeForView(text: String? = "", viewWidth: CGFloat, type: AlertType) -> CGFloat {
        
        var sizingView = PopAlertInnerView()
        sizingView.setNeedsLayout()
        sizingView.layoutIfNeeded()
        
        switch type {
        case .Contents, .Selection:
            let boxHeight:CGFloat = 56 + 1 + 20 + 20 // buttonHeight 56, lineViewHeight 1, leftMargin 20, rightMargin 20
            let labelfont = UIFont.hiraginokakugoW6(15)
            let width = viewWidth - (10 + 10) // label leftMargin 10, rightMargin 10
            let labelHeight = text!.sizeWithFont(labelfont, lineBreakMode: NSLineBreakMode.ByWordWrapping, constrainedToSize: CGSizeMake(width, CGFloat.max), lineSpacing: 8)
            return labelHeight.height + boxHeight
        case .UserBan:
            return sizingView.userBanView.frame.size.height
        case .AutoHide:
            return sizingView.toastView.frame.size.height
        }
    }
    
    
    
    
    
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        self.completeSelected(selected: true)
        self.delegate?.popAlertInnerViewCloseTapped()
    }
    
    
    @IBAction func tappedSelectionYesButton(sender: AnyObject) {
        self.completeSelected(selected: true)
        self.delegate?.popAlertInnerViewCloseTapped()
    }
    
    
    @IBAction func tappedSelectionNoButton(sender: AnyObject) {
        self.completeSelected(selected: false)
        self.delegate?.popAlertInnerViewCloseTapped()
    }
    
    @IBAction func tappedSelectionReportYesButton(sender: AnyObject) {
        self.completeSelected(selected: true)
        self.delegate?.popAlertInnerViewCloseTapped()
    }
    
    @IBAction func tappedSelectionReportNoButton(sender: AnyObject) {
        self.completeSelected(selected: false)
        self.delegate?.popAlertInnerViewCloseTapped()
    }
    
    
    deinit {
        Log("PopAlertInnerView deinit!")
    }
    
}