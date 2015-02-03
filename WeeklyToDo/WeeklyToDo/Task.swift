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
    @NSManaged var creation: NSDate
    @NSManaged var weekend : Weekend
}
