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
    
    class func weekdayFromNow(offset : Int, useStandardFormat : Bool) -> String {
        var dateFormatter = NSDateFormatter()
        
        if useStandardFormat==false {
            dateFormatter.locale = NSLocale.currentLocale()
        }
        
        dateFormatter.dateFormat = "EEEE"
        var date = NSDate(timeIntervalSinceNow: 60.0*60.0*24.0 * Double(offset))
        return dateFormatter.stringFromDate(date)
    }
}