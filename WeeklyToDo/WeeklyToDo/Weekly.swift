//
//  Weekly.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 22..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import Foundation

class Weekly {
    
    class func weekday(index : Int, useStandardFormat : Bool) -> String {
        // index에 해당하는 요일을 다국어로 변환한 후 반환
        // ie. index =0 is today
        var dateFormatter = NSDateFormatter()
        
        if useStandardFormat==false {
            dateFormatter.locale = NSLocale.currentLocale()
        }
        
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
    
    class func dateFromNow(toSymbol: String) -> NSDate? {
        var symbols = NSDateFormatter().weekdaySymbols + NSDateFormatter().weekdaySymbols
        var symbolOnToday = weekdayFromNow(0, useStandardFormat:false)
        var length = 0
        var foundedStartIndex = false
        for symbol in symbols {
            if symbol as String==symbolOnToday {
                foundedStartIndex = true
            }
            else if foundedStartIndex==true {
                ++length
            }
            
            if symbol as String == toSymbol {
                break
            }
        }
        
        var component = NSCalendar.currentCalendar().components(
            NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay,
            fromDate: NSDate(timeIntervalSinceNow: Double(60*60*24*length))
        )
        return NSCalendar.currentCalendar().dateFromComponents(component)
    }
//    class func lengthFromNow(toSymbol:String) -> Int {
//        var symbols = NSDateFormatter().weekdaySymbols + NSDateFormatter().weekdaySymbols
//        var symbolOnToday = weekdayFromNow(0, useStandardFormat:false)
//        var length = 0
//        var foundedStartIndex = false
//        for symbol in symbols {
//            if symbol as String==symbolOnToday {
//                foundedStartIndex = true
//            }
//            else if foundedStartIndex==true {
//                ++length
//            }
//            
//            if symbol as String == toSymbol {
//                break
//            }
//        }
//        return length
//    }
}