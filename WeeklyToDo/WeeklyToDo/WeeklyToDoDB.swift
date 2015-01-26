//
//  WeeklyToDoDB.swift
//  WeeklyToDo
//
//  Created by Cody on 2015. 1. 26..
//  Copyright (c) 2015년 TIEKLE. All rights reserved.
//

import CoreData
import UiKit

var todoCoreModelFileName = "Weekly_To_Do_DB"

class WeeklyToDoDB {
    class var sharedInstance : WeeklyToDoDB {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : WeeklyToDoDB? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = WeeklyToDoDB()
        }
        return Static.instance!
    }
    
    init() {
        var storedSymbols : [String] = [String]()
        if let fetchResults = self.managedObjectContext!.executeFetchRequest(NSFetchRequest(entityName: "Weekend"), error: nil) as? [Weekend] {
            for weekend in fetchResults {
                storedSymbols.append(weekend.symbol)
            }
        }
        
        var symbol : String
        for index in 0...6 {
            symbol = Weekly.weekday(index, useStandardFormat: false)
            let filtered = storedSymbols.filter { $0 == symbol }
            if filtered.count==0 {
                let weekend = NSEntityDescription.insertNewObjectForEntityForName("Weekend", inManagedObjectContext: self.managedObjectContext!) as Weekend
                weekend.symbol = symbol
            }
        }
        
        if self.managedObjectContext?.hasChanges==true {
            self.managedObjectContext?.save(nil)
        }
    }
    
    func countOftaskInWeekend(symbol:String) -> Int {
        if let fetchResults = self.managedObjectContext!.executeFetchRequest(NSFetchRequest(entityName: "Weekend"), error: nil) as? [Weekend] {
            for weekend in fetchResults {
                if weekend.symbol==symbol {
                    return weekend.tasks.count
                }
            }
        }
        return 0
    }
    
    lazy var applicationDocumentsDirectory: NSURL = {
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle.mainBundle().URLForResource("WeeklyToDo", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("WeeklyToDo.sqlite")
        var error: NSError? = nil
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext? = {
        
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
}