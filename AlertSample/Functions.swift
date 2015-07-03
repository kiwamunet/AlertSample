//
//  Functions.swift
//  VegasApp
//
//  Created by A12893 on 2014/12/18.
//  Copyright (c) 2014年 Ameba Studio. All rights reserved.
//


import Foundation

func dateFormatter() -> NSDateFormatter {
    let formatter = NSDateFormatter()
    //2014-12-30T19:30:00Z
    formatter.dateFormat="yyyy-MM-dd'T'HH:mm:ss'Z'"
    formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    return formatter
}


func unixDateFormatter() -> NSDateFormatter {
    let formatter = NSDateFormatter()
    //2015-04-23T16:10:00+09:00
    formatter.dateFormat="yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    formatter.timeZone = NSTimeZone(forSecondsFromGMT: 9)
    return formatter
}



func dateConversion(from: String, to: String) -> String {
    let formatter = NSDateFormatter()
    formatter.dateFormat="yyyy-MM-dd'T'HH:mm:ss'Z'"
    formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
    let date = formatter.dateFromString(from)
    formatter.dateFormat=to
    let str = formatter.stringFromDate(date!)
    return str
}

func dateFromUnixTimeMilisecond(unixTime: Double?) -> NSDate? {
    if unixTime == nil {
        return nil
    }
    let miliSeconds: Double = 1000
    let unixTimeSecond: Double = unixTime! / miliSeconds
    let dateFromUnixTime = NSDate(timeIntervalSince1970: unixTimeSecond)
    return dateFromUnixTime
}

func dateFromUnixTime(unixTime: Double?) -> NSDate? {
    if unixTime == nil {
        return nil
    }
    let dateFromUnixTime = NSDate(timeIntervalSince1970: unixTime!)
    return dateFromUnixTime
}

/**
DEBUG時にはログにFunction名と行番号を追記する
DEBUG以外は何もしない
*/

func Log(message: String,
    function: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__) {
        let attribute = [message,file,function,line]
        #if (DEBUG || DEV || ADHOC)
            println("Log \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
        #endif
}


/**
DEBUG時にはログに時間とFunction名と行番号を追記する
DEBUG以外は何もしない
*/

func LogWithTime(message: String,
    function: String = __FUNCTION__,
    file: String = __FILE__,
    line: Int = __LINE__) {
        #if DEBUG
            let now = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeStyle = .MediumStyle
            dateFormatter.dateStyle = .MediumStyle
            
            println("LogWithTime -\(dateFormatter.stringFromDate(now)) Message \"\(message)\" (File: \(file), Function: \(function), Line: \(line))")
        #endif
}


/**
復数のOptional値から、それらをアンラップしたタプルのOptionalを返す

:returns: tuple
*/
func optionalTuple<A, B>(a: A?, b: B?) -> (A, B)? {
    switch (a, b) {
    case (let .Some(uA), let .Some(uB)):
        return (uA, uB)
    default:
        return nil
    }
}

/**
復数のOptional値から、それらをアンラップしたタプルのOptionalを返す

:returns: tuple
*/
func optionalTuple<A, B, C>(a: A?, b: B?, c: C?) -> (A, B, C)? {
    switch (optionalTuple(a, b), c) {
    case (let .Some(uA, uB), let .Some(uC)):
        return (uA, uB, uC)
    default:
        return nil
    }
}

/**
復数のOptional値から、それらをアンラップしたタプルのOptionalを返す

:returns: tuple
*/
func optionalTuple<A, B, C, D>(a: A?, b: B?, c: C?, d: D?) -> (A, B, C, D)? {
    switch (optionalTuple(a, b), optionalTuple(c, d)) {
    case (let .Some(uA, uB), let .Some(uC, uD)):
        return (uA, uB, uC, uD)
    default:
        return nil
    }
}

/**
復数のOptional値から、それらをアンラップしたタプルのOptionalを返す

:returns: tuple
*/
func optionalTuple<A, B, C, D, E>(a: A?, b: B?, c: C?, d: D?, e: E?) -> (A, B, C, D, E)? {
    switch (optionalTuple(a, b), optionalTuple(c, d, e)) {
    case (let .Some(uA, uB), let .Some(uC, uD, uE)):
        return (uA, uB, uC, uD, uE)
    default:
        return nil
    }
}

/**
復数のOptional値から、それらをアンラップしたタプルのOptionalを返す

:returns: tuple
*/
func optionalTuple<A, B, C, D, E, F>(a: A?, b: B?, c: C?, d: D?, e: E?, f: F?) -> (A, B, C, D, E, F)? {
    switch (optionalTuple(a, b, c), optionalTuple(d, e, f)) {
    case (let .Some(uA, uB, uC), let .Some(uD, uE, uF)):
        return (uA, uB, uC, uD, uE, uF)
    default:
        return nil
    }
}

/**
復数のOptional値から、それらをアンラップしたタプルのOptionalを返す

:returns: tuple
*/
func optionalTuple<A, B, C, D, E, F, G>(a: A?, b: B?, c: C?, d: D?, e: E?, f: F?, g: G?) -> (A, B, C, D, E, F, G)? {
    switch (optionalTuple(a, b, c), optionalTuple(d, e, f, g)) {
    case (let .Some(uA, uB, uC), let .Some(uD, uE, uF, uG)):
        return (uA, uB, uC, uD, uE, uF, uG)
    default:
        return nil
    }
}

/**
復数のOptional値から、それらをアンラップしたタプルのOptionalを返す

:returns: tuple
*/
func optionalTuple<A, B, C, D, E, F, G, H>(a: A?, b: B?, c: C?, d: D?, e: E?, f: F?, g: G?, h: H?) -> (A, B, C, D, E, F, G, H)? {
    switch (optionalTuple(a, b, c, d), optionalTuple(e, f, g, h)) {
    case (let .Some(uA, uB, uC, uD), let .Some(uE, uF, uG, uH)):
        return (uA, uB, uC, uD, uE, uF, uG, uH)
    default:
        return nil
    }
}


//func isAspectRatio16x9() -> Bool {
//    var deviceRatio:Float = Float(UIScreen.commonWidth / UIScreen.commonHeight)
//    if UIApplication.isLandscape {
//        deviceRatio = Float(UIScreen.commonHeight / UIScreen.commonWidth)
//    }
//    let ratio:Float =  9 / 16
//    
//    return abs(deviceRatio - ratio) < 0.01
//}


func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}