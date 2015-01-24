//
//  Weekly.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import Foundation

class Weekly {
    
    class func weekday(index : Int) -> String {
        // index에 해당하는 요일을 다국어로 변환한 후 반환
        // ie. index =0 is today
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        return dateFormatter.weekdaySymbols[index] as String
    }
    
    class func weekdayFromNow(offset : Int) -> String {
        var dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateFormat = "EEEE"
        //var timeInterval : NSTimeInterval = 60.0*60.0*24.0* (Double)offset
        //var date = NSDate(timeIntervalSinceNow: )
        //var date = NSDate()
        //date.dateByAddingTimeInterval(ti:)
        //return dateFormatter.stringFromDate(NSDate(timeIntervalSinceNow: 60*60*24*offset))
        return ""
    }
}