//
//  Task.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 26..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {
    @NSManaged var repeat: NSNumber
    @NSManaged var todo: String
    @NSManaged var done: NSNumber
    @NSManaged var doneDate: NSDate?
    @NSManaged var creationDate: NSDate?
    @NSManaged var weekend : Weekend
    
    func didCreataionWhenPresent() -> Bool {
        if repeat.boolValue==true {
            return false
        }
        
        if creationDate==nil {
            return false
        }
        
        var component = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitHour | NSCalendarUnit.CalendarUnitMinute | NSCalendarUnit.CalendarUnitSecond, fromDate: NSDate())
        component.hour = 0
        component.minute = 0
        component.second = 0
        
        //let present = component.date
        let present = NSCalendar.currentCalendar().dateFromComponents(component)
        if present?.timeIntervalSince1970 > creationDate?.timeIntervalSince1970 {
            return true
        }
        
        return false
    }
    
    func didDoneWhenPresent() -> Bool {
        
        if done.boolValue==false {
            return false
        }
        
        var componentPresent = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay, fromDate: weekend.date!)
        
        var componentCurrent = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay, fromDate: NSDate())
        
        let present = NSCalendar.currentCalendar().dateFromComponents(componentPresent)
        let current = NSCalendar.currentCalendar().dateFromComponents(componentCurrent)
        
        if present?.timeIntervalSince1970 < current?.timeIntervalSince1970 && repeat.boolValue==true {
            return true
        }
        
        return false
    }
}
