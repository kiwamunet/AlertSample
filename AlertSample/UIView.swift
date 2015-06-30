//
//  UIViewExtension.swift
//  VegasApp
//
//  Created by A12893 on 2014/12/01.
//  Copyright (c) 2014年 Ameba Studio. All rights reserved.
//

import Foundation

protocol WithProxy {
    typealias ProxyType: UIView
    var proxy: ProxyType? { get set }
}

extension UIView {
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    
    var height: CGFloat {
        get { return frame.size.height }
        set { frame.size.height = newValue }
    }
    
    var width: CGFloat {
        get { return frame.size.width }
        set { frame.size.width = newValue }
    }
    
    var size: CGSize {
        get { return frame.size }
        set { frame.size = newValue }
    }
    
    func makeGradientMask(#gradientPattern: [(CGFloat, CGFloat)], horizontal: Bool = false) {
        doMakeGradient(gradientPattern, horizontal) { gradient, alphas in
            gradient.colors = gradientPattern.map { ($0.0 > 0 ? UIColor.alphaColor($0.0) : UIColor.clearColor()).CGColor! }
            gradient.locations = gradientPattern.map { $0.1 }
        }
    }
    
    func makeGradientMask(#alphas: [CGFloat], horizontal: Bool = false) {
        doMakeGradient(alphas, horizontal) { gradient, alphas in
            gradient.colors = alphas.map { ($0 > 0 ? UIColor.alphaColor($0) : UIColor.clearColor()).CGColor! }
        }
    }
    
    
    func makeLandscapeGradientMask(#alphas: [CGFloat], horizontal: Bool = false) {
        doLandscapeMakeGradient(alphas, horizontal) { gradient, alphas in
            gradient.colors = alphas.map { ($0 > 0 ? UIColor.alphaColor($0) : UIColor.clearColor()).CGColor! }
        }
    }
    
    
    
    private func doMakeGradient<T>(argument: T, _ horizontal: Bool, _ handleGradient:(gradient: CAGradientLayer, argument: T) ->()) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        if horizontal {
            gradient.startPoint = CGPointMake(0, 0)
            gradient.endPoint = CGPointMake(0, 1.0)
        }
        handleGradient(gradient: gradient, argument: argument)
        layer.mask = gradient
//        if layer.sublayers != nil && layer.sublayers.first is CAGradientLayer {
//            layer.sublayers.removeAtIndex(0)
//        }
//        layer.insertSublayer(gradient, atIndex: 0)
    }
    
    
    private func doLandscapeMakeGradient<T>(argument: T, _ horizontal: Bool, _ handleGradient:(gradient: CAGradientLayer, argument: T) ->()) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        if horizontal {
            gradient.startPoint = CGPointMake(0, 0)
            gradient.endPoint = CGPointMake(0, 1.0)
        }
        handleGradient(gradient: gradient, argument: argument)
        layer.mask = gradient
    }


    class func prepareProxyIfNeeded<T where T: UIView, T: WithProxy, T == T.ProxyType>(original: T) {
        if original.subviews.count == 0 {
            let proxy = NSBundle.mainBundle().loadNibNamed(String(T), owner: nil, options: nil)[0] as! T
            proxy.frame = original.bounds
            let s = NSStringFromCGRect(original.frame)
            proxy.autoresizingMask = .FlexibleWidth | .FlexibleHeight
            original.proxy = proxy
            original.addSubview(proxy)
        }
    }
    
   
    /**
    subView内のFirstResponderのViewを返す
    */
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder() {
            return self
        }
        for subView in self.subviews {
            if subView.isFirstResponder() {
                return subView as? UIView
            }
            if (subView.findFirstResponder() != nil) {
                return subView.findFirstResponder()
            }
        }
        return nil
    }
    
    class func screenCapture(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 2.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return capture
    }
    
    
    class func navigationView(frame: CGRect, fontType: String, textType: String, fontsize: CGFloat) -> UIView {
        var view: UIView = UIView(frame: frame)
        view.backgroundColor = UIColor.clearColor()
        let label = UILabel(frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height))
        label.font = UIFont(name: fontType, size: fontsize)
        label.textAlignment = NSTextAlignment.Center
        label.text = textType
        label.textColor = UIColor.whiteColor()
        label.backgroundColor = UIColor.clearColor()
        view.addSubview(label)
        return view
    }
    
}

