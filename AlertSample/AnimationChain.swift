//
//  AnimationChain.swift
//  VegasApp
//
//  Created by A12893 on 2014/12/11.
//  Copyright (c) 2014年 Ameba Studio. All rights reserved.
//
import UIKit

private let defaultOptions = UIViewAnimationOptions.CurveEaseOut

class AnimationChain {
    private var duration: NSTimeInterval!
    private var delay: NSTimeInterval!
    private var options: UIViewAnimationOptions!
    private var springOptions: (dampingRatio: CGFloat, initialSpringVelocity: CGFloat)?
    private var animationCallback: (()->())!
    private var completionCallback: (()->())?
    private var next: AnimationChain?
    private var previous: AnimationChain?
    private var root: AnimationChain {
        var parent: AnimationChain! = self
        while parent != nil {
            if parent.previous == nil {
                return parent
            }
            parent = parent.previous
        }
        return self
    }
    
    private init() { }
    
    class func animate(
            duration: NSTimeInterval,
            delay: NSTimeInterval = 0,
            options: UIViewAnimationOptions = defaultOptions,
            springOptions: (dampingRatio: CGFloat, initialSpringVelocity: CGFloat)? = nil,
            animation: ()->()) -> AnimationChain {
        let chain = AnimationChain()
        chain.duration = duration
        chain.delay = delay
        chain.options = options
        chain.animationCallback = animation
        chain.springOptions = springOptions
        return chain
    }
    
    func completion(completionCallback: ()->()) -> AnimationChain {
        self.completionCallback = completionCallback
        return self
    }
    
    func thenAnimate(
            duration: NSTimeInterval,
            delay: NSTimeInterval = 0,
            options: UIViewAnimationOptions = defaultOptions,
            springOptions: (dampingRatio: CGFloat, initialSpringVelocity: CGFloat)? = nil,
            animation: ()->()) -> AnimationChain {
        let next = AnimationChain()
        next.duration = duration
        next.delay = delay
        next.options = options
        next.animationCallback = animation
        next.previous = self
        next.springOptions = springOptions
        self.next = next
        return next
    }
    
    func start() {
        AnimationChain.doStart(root)
    }
    
    private class func doStart(chain: AnimationChain) {
        let startAnimation: (Bool->())->() = { completion in
            if let springOptions = chain.springOptions {
                UIView.animateWithDuration(
                    chain.duration,
                    delay: chain.delay,
                    usingSpringWithDamping: springOptions.dampingRatio,
                    initialSpringVelocity: springOptions.initialSpringVelocity,
                    options: chain.options,
                    animations: chain.animationCallback,
                    completion: completion)
            } else {
                UIView.animateWithDuration(
                    chain.duration,
                    delay: chain.delay,
                    options: chain.options,
                    animations: chain.animationCallback,
                    completion: completion)
            }
        }
        startAnimation { _ in
            chain.completionCallback?()
            if let next = chain.next {
                self.doStart(next)
            }
        }
    }
}
