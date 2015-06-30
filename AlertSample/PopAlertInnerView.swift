//
//  PopAlertInnerView.swift
//  VegasApp
//
//  Created by tanaka_yu_gn on 2015/04/02.
//  Copyright (c) 2015年 Ameba Studio. All rights reserved.
//

import Foundation

protocol PopAlertInnerViewDelegate: class {
    func popAlertInnerViewCloseTapped()
}

class PopAlertInnerView: UIView {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var contentsView: UIView!
    @IBOutlet weak var contentsLabel: UILabel!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var selectionLabel: UILabel!
    @IBOutlet weak var selectionYesButton: UIButton!
    @IBOutlet weak var selectionNoButton: UIButton!
    @IBOutlet weak var selectionReport: UIView!
    @IBOutlet weak var selectionReportImage: UIImageView!
    @IBOutlet weak var selectionReportName: UILabel!
    @IBOutlet weak var selectionReportText: UILabel!
    @IBOutlet weak var selectionReportComment: UILabel!
    @IBOutlet weak var selectionReportYesButton: UIButton!
    @IBOutlet weak var selectionReportNoButton: UIButton!
    @IBOutlet weak var agreementView: UIView!
    @IBOutlet weak var agreementLabel: UILabel!
    @IBOutlet weak var agreementButton: UIButton!
    @IBOutlet weak var toastView: UIView!
    @IBOutlet weak var authMark: UILabel!
    
    
    weak var delegate: PopAlertInnerViewDelegate?
    private var mainView:UIView? = nil
    private var closeRejection = false
    
    var selectionCompletion: ((Bool) -> ())? = nil
    var selectionReportCompletion: ((Bool) -> ())? = nil
    var agreementCompletion: (() -> ())? = nil
    
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
    
    func setTypeLayout(type: AlertContentType, block: () -> ()) {
        let lineHeight:CGFloat = 20.0
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        
        switch type {
        case let .Contents(str):
            self.contentsView.hidden = false
            self.closeButton.titleLabel?.textColor = UIColor.baseColor()
            let attributedText = NSMutableAttributedString(string: str)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            self.contentsLabel.attributedText = attributedText
            self.contentsLabel.textAlignment = NSTextAlignment.Center
            self.contentsLabel.sizeToFit()
            block()
            break
        case let .Selection((yes,no), str, completion):
            self.selectionView.hidden = false
            let attributedText = NSMutableAttributedString(string: str)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            self.selectionLabel.attributedText = attributedText
            self.selectionLabel.textAlignment = NSTextAlignment.Center
            self.selectionLabel.sizeToFit()
            self.selectionYesButton.setTitle(yes, forState: UIControlState.Normal)
            self.selectionNoButton.setTitle(no, forState: UIControlState.Normal)
            self.selectionCompletion = completion
            block()
            break
        case let .SelectionReport((yes, no), str, image, name, reportMsg, completion):
            self.selectionReport.hidden = false
            let attributedText = NSMutableAttributedString(string: str)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            self.selectionReportText.attributedText = attributedText
            self.selectionReportText.textAlignment = NSTextAlignment.Center
            self.selectionReportText.sizeToFit()
            self.selectionReportImage.image = image
            self.selectionReportName.text = name
            self.selectionReportComment.text = reportMsg
            self.selectionReportYesButton.setTitle(yes, forState: UIControlState.Normal)
            self.selectionReportNoButton.setTitle(no, forState: UIControlState.Normal)
            self.selectionReportCompletion = completion
            block()
            break
        case let .Agreement(title, str, completion):
            self.agreementView.hidden = false
            let attributedText = NSMutableAttributedString(string: str)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            self.agreementLabel.attributedText = attributedText
            self.agreementLabel.textAlignment = NSTextAlignment.Center
            self.agreementLabel.sizeToFit()
            self.agreementButton.setTitle(title, forState: UIControlState.Normal)
            self.agreementCompletion = completion
            self.closeRejection = false
            block()
            break
        case let .Update(title, str, completion):
            self.agreementView.hidden = false
            let attributedText = NSMutableAttributedString(string: str)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 8
            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            self.agreementLabel.attributedText = attributedText
            self.agreementLabel.textAlignment = NSTextAlignment.Center
            self.agreementLabel.sizeToFit()
            self.agreementButton.setTitle(title, forState: UIControlState.Normal)
            self.agreementCompletion = completion
            self.closeRejection = true
            block()
            break
        case let .Toast():
            self.toastView.hidden = false
            self.authMark.text = icomoon.e602
            self.authMark.adjustsFontSizeToFitWidth = true
            self.authMark.layer.cornerRadius = self.authMark.size.width * 0.5
            self.authMark.clipsToBounds = true
//            let attributedText = NSMutableAttributedString(string: "連携完了")
//            attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
            block()
            break
        }
    }
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        delegate?.popAlertInnerViewCloseTapped()
    }
    
    
    @IBAction func tappedSelectionYesButton(sender: AnyObject) {
        if selectionCompletion != nil {
            self.selectionCompletion!(true)
        } else {
            Log("AlertView completion Error")
        }
        delegate?.popAlertInnerViewCloseTapped()
    }
    
    
    @IBAction func tappedSelectionNoButton(sender: AnyObject) {
        if selectionCompletion != nil {
            self.selectionCompletion!(false)
        } else {
            Log("AlertView completion Error")
        }
        delegate?.popAlertInnerViewCloseTapped()
    }
    
    @IBAction func tappedSelectionReportYesButton(sender: AnyObject) {
        if selectionReportCompletion != nil {
            self.selectionReportCompletion!(true)
        } else {
            Log("AlertView completion Error")
        }
        delegate?.popAlertInnerViewCloseTapped()
    }
    
    @IBAction func tappedSelectionReportNoButton(sender: AnyObject) {
        if selectionReportCompletion != nil {
            self.selectionReportCompletion!(false)
        } else {
            Log("AlertView completion Error")
        }
        delegate?.popAlertInnerViewCloseTapped()
    }
    
    @IBAction func tappedAgreementButton(sender: AnyObject) {
        if agreementCompletion != nil {
            self.agreementCompletion!()
        } else {
            Log("AlertView completion Error")
        }
        if !self.closeRejection {
            delegate?.popAlertInnerViewCloseTapped()
        }
    }
    
    deinit {
        Log("PopAlertInnerView deinit!")
    }
    
}