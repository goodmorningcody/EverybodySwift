//
//  Weekend.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 26..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import Foundation
import CoreData

class Weekend: NSManagedObject {
    @NSManaged var symbol: String
    @NSManaged var tasks: NSSet
}
